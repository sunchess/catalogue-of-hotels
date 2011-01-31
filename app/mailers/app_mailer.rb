class AppMailer < ActionMailer::Base
  default :from => "coastsun.ru@gmail.com"
  helper :reserves
  helper :rooms
  helper :application

  #Посылаем письмо менеджеру, когда заказчик отсылает заказ
  def new_reserve(reserve)
    @reserve = reserve
    mail(:to => ["sunchess@inbox.ru", "kboss@inbox.ru", "coastsun.ru@gmail.com"], :subject => "New reserve created::CoastSun.Ru")  
  end
end
