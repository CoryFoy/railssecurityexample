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

  def upload
    name =  params['datafile'].original_filename
    directory = "uploads/mycompany"
    # create the file path
    path = File.join(directory, name)
    # write the file
    File.open(path, "wb") { |f| f.write(params['datafile'].read) }
    redirect_to "/bad/show_files?company=mycompany"
  end

  def download_file
    send_file("uploads/#{params[:company]}/#{params[:file]}")
  end

  def show_files
    @company = params["company"]
    directory = Dir.new("uploads/#{@company}")
    @files = directory.entries
    render "uploaded_files"
  end

  def redirect
    redirect_to params[:url]
  end

  def process_payment
    @amount = params[:amount]
    @cc_number = params[:cc]
    @expire_date = params[:expire]
    Payment.create!(
      :amount => @amount,
      :cc_number => @cc_number,
      :expire_date => @expire_date
    )
    render "payment_receipt"
  end
end
