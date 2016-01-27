$vacuum = Vacuum.new('FR')
$vacuum.configure(
      aws_access_key_id: Rails.application.secrets.amazon_access_key,
      aws_secret_access_key: Rails.application.secrets.amazon_secret_key,
      associate_tag: 'amazon search'
    )
