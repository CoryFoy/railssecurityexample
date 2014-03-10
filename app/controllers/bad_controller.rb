class BadController < ApplicationController
  def injection
    query = "SELECT NAME from users WHERE id = #{params[:id]}"

    conn = ActiveRecord::Base.connection
    name = conn.execute(query)
    render :text => name.values
  end

  def comments
    render "show_comments"
  end

  def save_comment
    Comment.create!(:comment => params["comment"])
    render "show_comments"
  end
end
