module TestJob
  @queue = :test

  def self.perform
    p 'RESQUE JOB WORKS'
  end

end
