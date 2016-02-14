require 'taglib'

ARGV.each do |path|
  TagLib::MPEG::File.open(path) do |file|
    removed = 0

    tag = file.id3v2_tag
    tag.frame_list.each do |frame|
      if frame.is_a? TagLib::ID3v2::CommentsFrame
        puts "Removed comment frame"
      elsif frame.is_a? TagLib::ID3v2::PrivateFrame
        puts "Removed private frame"
      else
        next
      end

      tag.remove_frame(frame)
      removed += 1
    end

    next unless 0 < removed
    file.save(TagLib::MPEG::File::ID3v2)
  end
end
