configure :production, :development do
	db = URI.parse(ENV['DATABASE_URL'] || 'postgres://localhost/usershare')

	DataMapper.setup(:default, ENV['DATABASE_URL'] ||"postgres://postgres:dinesh 770@localhost/usershare")

end