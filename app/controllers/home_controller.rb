class HomeController < ApplicationController
  def result
    if @postal_code = params[:postal_code]
      params = URI.encode_www_form({zipcode: @postal_code})
      uri = URI.parse("http://zipcloud.ibsnet.co.jp/api/search?#{params}")
      response = Net::HTTP.get_response(uri)
      result = JSON.parse(response.body)
      if result["results"]
        @zipcode = result["results"][0]["zipcode"]
        @address1 = result["results"][0]["address1"]
        @address2 = result["results"][0]["address2"]
        @address3 = result["results"][0]["address3"]
        flash[:notice] = nil
      else
        if flash[:notice] = result["message"]
          render("home/result")
        else
          flash[:notice] = "郵便番号が存在しません。"
        end
      end
    end
  end
end
