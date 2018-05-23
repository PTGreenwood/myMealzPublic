# -*- encoding : utf-8 -*-
Rails.configuration.stripe = {
    :publishable_key => Rails.application.secrets.stripe_publish_key,
    :secret_key => Rails.application.secrets.stripe_secret_key
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
