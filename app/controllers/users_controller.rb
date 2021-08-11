class UsersController < ApplicationController

  def pricing
  end

  def payment
    @fee = ENV["price_#{params[:type]}"]
    @payment_type = (params[:type] == 'gold' ? 'Gold' : 'Platinum' )
    @token = gateway.client_token.generate
  end

  def pay
    fee = ENV["price_#{params[:type]}"]
    nonce = params[:payment_method_nonce]

    result = gateway.transaction.sale(
      amount: fee,
      payment_method_nonce: nonce,
      # device_data: device_data_from_the_client,
      options: {
        submit_for_settlement: true
      }
    )

    if result.success?
      # send 方法，可接收傳來的 method 並執行
      current_user.send("#{params[:type]}_user!") # meta programming
      redirect_to root_path, notice: 'OK'
    else
      redirect_to root_path, notice: 'Error'
    end
  end

  private

  def gateway
    Braintree::Gateway.new(
      environment: :sandbox,
      merchant_id: ENV['braintree_merchant_id'],
      public_key: ENV['braintree_public_key'],
      private_key: ENV['braintree_private_key'],
    )
  end

end
