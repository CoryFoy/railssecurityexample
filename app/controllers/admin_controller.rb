class AdminController < ApplicationController
  def show_cc
    @payments = Payment.all
  end
end
