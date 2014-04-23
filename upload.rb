require 'sinatra'
require 'FileUtils'

# 参考例子
# http://stackoverflow.com/questions/2686044/file-upload-with-sinatra
# http://www.wooptoot.com/file-upload-with-sinatra
# https://gist.github.com/gavinheavyside/225381

# 默认上传文件存放的目录是脚本所处目录的upload文件夹
UPLOAD_PATH = 'upload'

get '/' do
  erb :index # 去修改 views/index.erb
end

post '/upload' do
  content_type :text

  # 实际保存文件
  params['images'].each do |f|
    # 防止同名文件覆盖之前的
    # 我们给文件名加上时间戳？
    new_filename = "#{f[:filename]}_#{Time.now.strftime('%Y-%m-%d-%H-%M-%S')}"
    FileUtils.cp f[:tempfile], "#{UPLOAD_PATH}/#{new_filename}"
  end

  # 给用户反馈信息
  params['images'].reduce("接受到以下文件：\n") { |a, f| a << f[:filename] << "\n" }
end
