 CatalogueOfHotels::Application.config.middleware.use ExceptionNotifier,
        :email_prefix => "[CoastSun.Ru] ",
        :sender_address => %{"notifier" <alexanderdmv@gmail.com>},
        :exception_recipients => %w{alexanderdmv@gmail.com}
