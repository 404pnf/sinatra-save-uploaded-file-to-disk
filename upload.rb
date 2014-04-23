require 'sinatra'
require 'FileUtils'

# 参考例子
# http://stackoverflow.com/questions/2686044/file-upload-with-sinatra
# http://www.wooptoot.com/file-upload-with-sinatra
# https://gist.github.com/gavinheavyside/225381

UPLOAD_PATH = 'upload'

get '/' do
  <<-HTML
  <html>
  <head><title>可以一次选多个文件</title></head>
  <body>
    <form action="/upload" method="post" enctype="multipart/form-data">
      <input type="file" name="images[]" multiple />
      <input type="submit" />
    </form>
  </body>
  </html>
  HTML
end

post '/upload' do
  content_type :text

  # 实际保存文件
  params['images'].each do |f|
    #File.write("#{UPLOAD_PATH}/#{f[:filename]}", f[:tempfile].read)
    FileUtils.cp f[:tempfile], "#{UPLOAD_PATH}/#{f[:filename]}"
  end

  # 给用户反馈信息
  res = "接受到以下文件：\n"
  res << params['images'].map { |f| f[:filename] }.join("\n")
  res
end
