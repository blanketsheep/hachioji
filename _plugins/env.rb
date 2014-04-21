module Jekyll
	
	class Env < Generator
		
		def generate(site)
			site.config['env'] = {}
			site.config['env']['build'] = ENV['JEKYLL_BUILD'] || 'local'
		end
		
	end
	
end
