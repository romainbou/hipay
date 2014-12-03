# Hipay

Provide Cash Out and TPP integration clients

## Installation

Add this line to your application's Gemfile:

    gem 'hipay'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hipay

## Usage

Refer to the hipay documentation for each client specific usage and endpoints

### Cash out client (SOAP)


```ruby
client = Hipay::Client.new base_url: "https://test-ws.hipay.com/soap",
   wsLogin: "my_login",
   wsPassword: "my_password",
   entity: "my_entity"

client.user_account.operations
=> [:send_activation_mail,
 :create,
 :create_with_website,
 :create_full_user_account,
 :is_available,
 :get_available_payment_methods,
 :get_balance,
 :get_transactions,
 :bank_infos_check,
 :bank_infos_fields,
 :bank_infos_status,
 :bank_infos_register,
 :get_account_infos,
 :associate_merchant_group,
 :create_subaccount,
 :set_merchant_notification_in_post,
 :set_merchant_token_in_notification]

client.transfer.operations
=> [:direct]

client.withdrawal.operations
=> [:create]
```

The client
* camelize the method name and the params before to call the hipay webservice
* extract the response from its enveloppe, hashify the xml returned, and underscorize the result

```ruby
client.user_account.call :is_available, email: 'test_test@gmail.com'
=> {"description"=>"Email available : test_test@gmail.com", "is_available"=>true}

```

### TPP client (REST)

```ruby
tpp_client = Hipay::Client::TPP.new    url: "https://#{base_url}/rest/v1/",
                                username: "my_login",
                                password: 'my_password'

tpp_client.get("/orders/#{order_id}")
```


## Contributing

1. Fork it ( https://github.com/[my-github-username]/hipay/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
