class ProfileDecorator < Draper::Decorator
  delegate_all

  def fkf
    "test"
  end
end
