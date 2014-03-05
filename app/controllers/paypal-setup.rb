
# @api = PayPal::SDK::REST.set_config(
#     :ssl_options => {}, # Set ssl options
#     :mode => :sandbox,  # Set :sandbox or :live
#     :client_id     => "AdbapRD-IY8sn3hwDna4QPgCcVimUfS1HSRzDZkG8wXLGWe4X_TDlU9dQWqd",
#     :client_secret => "EPt9xhAPVCVHW-_pVsWfa5JYYuLbQD9h11up-larKFx4xm73xpOghJQ3MZsD" )

# curl https://api.sandbox.paypal.com/v1/oauth2/token \
#  -H "Accept: application/json" \
#  -H "Accept-Language: en_US" \
#  -u "AdbapRD-IY8sn3hwDna4QPgCcVimUfS1HSRzDZkG8wXLGWe4X_TDlU9dQWqd:EPt9xhAPVCVHW-_pVsWfa5JYYuLbQD9h11up-larKFx4xm73xpOghJQ3MZsD" \
#  -d "grant_type=client_credentials"


# {
#   "scope" : "https://api.paypal.com/v1/payments/.* https://api.paypal.com/v1/vault/credit-card https://api.paypal.com/v1/vault/credit-card/.*",
#   "access_token" : "V0baGZJsjhoEr4728t6-o3jrLEd.nCBneLEPoLKOd.4", 
#   "token_type"   : "Bearer", 
#   "app_id"       : "APP-80W284485P519543T" , 
#   "expires_in"   : 28800 # seconds
# }




# curl -v https://api.sandbox.paypal.com/v1/payments/payment \
# -H "Content-Type:application/json" \
# -H "Authorization:Bearer V0baGZJsjhoEr4728t6-o3jrLEd.nCBneLEPoLKOd.4" \
# -d '{
#   "intent": "sale",
#   "payer": {
#     "payment_method": "credit_card",
#     "funding_instruments": [
#       {
#         "credit_card": {
#           "number": "5500005555555559",
#           "type": "mastercard",
#           "expire_month": 12,
#           "expire_year": 2018,
#           "cvv2": 111,
#           "first_name": "Joe",
#           "last_name": "Shopper"
#         }
#       }
#     ]
#   },
#   "transactions": [
#     {
#       "amount": {
#         "total": "7.47",
#         "currency": "USD"
#       },
#       "description": "This is the payment transaction description."
#     }
#   ]
# }'


# py = Payment.new({
#   :intent => "sale",
#   :payer => {
#     :payment_method => "credit_card",
#     :funding_instruments => [{
#       :credit_card => {
#         :type => "visa",
#         :number => "4417119669820331",
#         :expire_month => "04",
#         :expire_year => "2018",
#         :cvv2 => "874",
#         :first_name => "Joe",
#         :last_name => "Shopper",
#         :billing_address => {
#           :line1 => "52 N Main ST",
#           :city => "Johnstown",
#           :state => "OH",
#           :postal_code => "43210",
#           :country_code => "US" 
#         }
#       }
#     }]
#   },
#   :transactions => [{
#     :item_list => {
#       :items => [
#         { :name => "item",
#           :sku => "item",
#           :price => "1",
#           :currency => "USD",
#           :quantity => 1 
#         }
#     ]},
#     :amount => {
#       :total => "299.99",
#       :currency => "USD" 
#     },
#     :description => "This is the payment transaction description." 
#   }]
# })


# @refund = sale.refund({
#   :amount => {
#     :currency => "USD",
#     :total => "1.47" })