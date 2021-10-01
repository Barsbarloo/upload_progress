# app/services/video_converter.rb

class VideoConverter
  def initialize(user_id)
    @user = User.find(user_id)
  end

  def convert!
    process_video
  end

  private

  def process_video
    @user.profile_video.open(tmpdir: "/tmp") do |file|
      movie = FFMPEG::Movie.new(file.path)
      path = "tmp/video-#{SecureRandom.alphanumeric(12)}.gif"
      movie.transcode(path)
      @user.profile_video.attach(io: File.open(path), filename: "video-#{SecureRandom.alphanumeric(12)}.gif", content_type: 'image/gif')
    end
  end
end