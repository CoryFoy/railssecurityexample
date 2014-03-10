class BadController < ApplicationController
  def injection
    query = "SELECT NAME from users WHERE id = #{params[:id]}"

    conn = ActiveRecord::Base.connection
    name = conn.execute(query)
    render :text => name.values
  end
end
