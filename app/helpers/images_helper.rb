module ImagesHelper

  def safely_url id, version = false

    if version
      File.join('/get_image', id.to_s, version )
    else
      File.join('/get_image', id.to_s )
    end

  end

end
