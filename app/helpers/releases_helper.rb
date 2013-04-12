module ReleasesHelper
  def download_release(release)
    if release.tracks.count >0
      file_name = "#{release.title}.zip"
      t = Tempfile.new("Release-Temp_file-#{Time.now}")
      Zip::ZipFile.open(t.path, Zip::ZipFile::CREATE) do |z|
        release.tracks.each do |track|
          title = track.file_file_name
          z.put_next_entry(title)
          z.print IO.read(track.path)
        end
        if !release.cover.blank?
          cover = release.cover_file_name
          z.put_next_entry(cover)
          z.print IO.read(release.cover.path)
        end
        file = File.open(t)
        release.zip = file
        file.close
        release.save
        t.close
      end
    end              
  end
end
