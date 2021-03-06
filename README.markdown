#ASP world tour comp data
I'm interested in doing something with all the competition data from the ASP (Association of Surfing Professionals) world tour. Lots of things that can be done. How exciting!

##Example
This is pulled from [the Rip Curl Pro file in examples/](http://github.com/DylanFM/asp-scores/blob/3b3e31edaca6809b075f3f65bd2e912f07f3f3a3/example/rip_curl_pro.rb).

Here's [a screenshot of the interface](http://github.com/DylanFM/asp-scores/blob/d621d268318dca314c72bb1b943b08c3a67ca9a2/example/interface-screenshot.png) (at this stage) with the Rip Curl Pro data.

After setting up your database and running rake auto_migrate, run the first 5 lines of code below to get all the data from the Rip Curl Pro at Bells Beach 2009.

		# Make a new competition
		rcp = CompScraper::Competition.create(
		    :base_url => 'http://www.beachbyte.com/live09/rcp09/',
		    :name => "Rip Curl Pro Bells Beach 2009"
		  )
		rcp.save_comp_data

		# It's only code for output from here on...
		puts rcp.name
		rcp.rounds.all.each do |round|
		  puts "#{round.gender == 'f' ? "Women's" : "Men's"} #{round}:"
		  round.heats.all.each do |heat|
		    winner = heat.competitors.first(:place => 1)
		    loser = heat.competitors.first(:place => 2)
		    puts "\tHeat #{heat.number} - #{winner.surfer.name} beat #{loser.surfer.name} who needed #{loser.diff_amount} points"
		  end
		end
		# >> Rip Curl Pro Bells Beach 2009
		# >> Men's Round 1:
		# >> 	Heat 1 - David Weare beat Nathaniel Curran who needed 6.68 points
		# >> 	Heat 2 - Michel Bourez beat Roy Powers who needed 8.4 points
		# >> 	Heat 3 - Jay Thompson beat Heitor Alves who needed 14.67 points
		# >> 	Heat 4 - Taylor Knox beat Phillip MacDonald who needed 9.51 points
		# >> 	Heat 5 - Dayyan Neve beat Marlon Lipke who needed 14.0 points
		# >> 	Heat 6 - Kieren Perrow beat Aritz Aranburu who needed 5.27 points
		# >> 	Heat 7 - Jihad Khodr beat Patrick Gudauskas who needed 6.5 points
		# >> 	Heat 8 - Owen Wright beat Dane Reynolds who needed 6.68 points
		# >> 	Heat 9 - Jordy Smith beat Matt Wilkinson who needed 18.71 points
		# >> 	Heat 10 - Adam Robertson beat Chris Davidson who needed 3.9 points
		# >> 	Heat 11 - Mick Campbell beat Josh Kerr who needed 8.66 points
		# >> 	Heat 12 - Dean Morrison beat Nic Muscroft who needed 6.93 points
		# >> 	Heat 13 - Kekoa Bacalso beat Ben Dunn who needed 6.13 points
		# >> 	Heat 14 - Drew Courtney beat Greg Emslie who needed 8.11 points
		# >> 	Heat 15 - Tim Boal beat Michael Picon who needed 8.57 points
		# >> 	Heat 16 - Tiago Pires beat Dustin Barca who needed 7.5 points
		# >> Men's Round 2:
		# >> 	Heat 1 - CJ Hobgood beat Mick Campbell who needed 9.67 points
		# >> 	Heat 2 - Taylor Knox beat Chris Ward who needed 16.94 points
		# >> 	Heat 3 - Kai Otton beat Dayyan Neve who needed 6.18 points
		# >> 	Heat 4 - Joel Parkinson beat Michel Bourez who needed 16.77 points
		# >> 	Heat 5 - Mick Fanning beat Tiago Pires who needed 8.4 points
		# >> 	Heat 6 - Bobby Martinez beat Tim Boal who needed 16.41 points
		# >> 	Heat 7 - Jordy Smith beat Damien Hobgood who needed 5.84 points
		# >> 	Heat 8 - Owen Wright beat Kelly Slater who needed 7.67 points
		# >> 	Heat 9 - Adam Robertson beat Bede Durbidge who needed 7.94 points
		# >> 	Heat 10 - Tom Whitaker beat Jihad Khodr who needed 7.57 points
		# >> 	Heat 11 - Drew Courtney beat Adriano de Souza who needed 8.15 points
		# >> 	Heat 12 - Kekoa Bacalso beat Jeremy Flores who needed 8.11 points
		# >> 	Heat 13 - Jay Thompson beat Taj Burrow who needed 8.0 points
		# >> 	Heat 14 - Kieren Perrow beat Tim Reyes who needed 16.57 points
		# >> 	Heat 15 - Dean Morrison beat Adrian Buchan who needed 13.5 points
		# >> 	Heat 16 - Fredrick Patacchia beat David Weare who needed 6.18 points
		# >> Men's Round 3:
		# >> 	Heat 1 - CJ Hobgood beat Taylor Knox who needed 8.5 points
		# >> 	Heat 2 - Joel Parkinson beat Kai Otton who needed  points
		# >> 	Heat 3 - Mick Fanning beat Bobby Martinez who needed 14.27 points
		# >> 	Heat 4 - Jordy Smith beat Owen Wright who needed 9.67 points
		# >> 	Heat 5 - Adam Robertson beat Tom Whitaker who needed 8.67 points
		# >> 	Heat 6 - Kekoa Bacalso beat Drew Courtney who needed 17.35 points
		# >> 	Heat 7 - Kieren Perrow beat Jay Thompson who needed 7.5 points
		# >> 	Heat 8 - Fredrick Patacchia beat Dean Morrison who needed 17.58 points
		# >> Men's Quarter-final:
		# >> 	Heat 1 - Joel Parkinson beat CJ Hobgood who needed 7.84 points
		# >> 	Heat 2 - Jordy Smith beat Mick Fanning who needed 7.68 points
		# >> 	Heat 3 - Adam Robertson beat Kekoa Bacalso who needed 7.43 points
		# >> 	Heat 4 - Fredrick Patacchia beat Kieren Perrow who needed 7.46 points
		# >> Men's Semi-final:
		# >> 	Heat 1 - Joel Parkinson beat Jordy Smith who needed 8.66 points
		# >> 	Heat 2 - Adam Robertson beat Fredrick Patacchia who needed 7.47 points
		# >> Men's Final:
		# >> 	Heat 1 - Joel Parkinson beat Adam Robertson who needed 17.41 points
		# >> Women's Round 1:
		# >> 	Heat 1 - Sally Fitzgibbons beat Amee Donohoe who needed 7.9 points
		# >> 	Heat 2 - Layne Beachley beat Rosanne Hodge who needed  points
		# >> 	Heat 3 - Stephanie Gilmore beat Bruna Schmitz who needed 7.44 points
		# >> 	Heat 4 - Chelsea Hedges beat Silvana Lima who needed 7.24 points
		# >> 	Heat 5 - Sofia Mulanovich beat Alana Blanchard who needed 8.16 points
		# >> 	Heat 6 - Samantha Cornish beat Jacqueline Silva who needed 4.94 points
		# >> Women's Round 2:
		# >> 	Heat 1 - Coco Ho beat Nikki Van Dijk who needed 8.34 points
		# >> 	Heat 2 - Rebecca Woods beat Paige Hareb who needed 5.5 points
		# >> Women's Round 3:
		# >> 	Heat 1 - Sally Fitzgibbons beat Layne Beachley who needed 16.51 points
		# >> 	Heat 2 - Jacqueline Silva beat Amee Donohoe who needed 6.33 points
		# >> 	Heat 3 - Paige Hareb beat Coco Ho who needed 8.84 points
		# >> 	Heat 4 - Stephanie Gilmore beat Nikki Van Dijk who needed 17.84 points
		# >> 	Heat 5 - Silvana Lima beat Alana Blanchard who needed 7.0 points
		# >> 	Heat 6 - Rebecca Woods beat Chelsea Hedges who needed 7.34 points
		# >> 	Heat 7 - Samantha Cornish beat Bruna Schmitz who needed 7.83 points
		# >> 	Heat 8 - Sofia Mulanovich beat Rosanne Hodge who needed 5.93 points
		# >> Women's Quarter-final:
		# >> 	Heat 1 - Sally Fitzgibbons beat Jacqueline Silva who needed 7.34 points
		# >> 	Heat 2 - Stephanie Gilmore beat Paige Hareb who needed 3.94 points
		# >> 	Heat 3 - Silvana Lima beat Rebecca Woods who needed 3.0 points
		# >> 	Heat 4 - Sofia Mulanovich beat Samantha Cornish who needed 6.27 points
		# >> Women's Semi-final:
		# >> 	Heat 1 - Stephanie Gilmore beat Sally Fitzgibbons who needed 16.61 points
		# >> 	Heat 2 - Silvana Lima beat Sofia Mulanovich who needed 15.0 points
		# >> Women's Final:
		# >> 	Heat 1 - Silvana Lima beat Stephanie Gilmore who needed 9.51 points

##Here are some example URLS:
* [Heats in a round](http://www.beachbyte.com/live09/rcp09/mr1.asp) (_supported_)
* [Scores for a heat per judge per wave per surfer](http://www.beachbyte.com/live09/rcp09/mr1sc01.asp?rLingua=) (_suppported_)
* [Like a wave-by-wave log or transcript for a heat](http://www.beachbyte.com/live09/rcp09/mr1pf01.asp?rLingua=)

_The ones marked as supported can be parsed with this code._

I'd like to get each of these pages supported and to plonk everything into a database so we can have lotsa fun.

##Requirements
* Nokogiri
* Tidy (change the path in lib/comp_scraper.rb to your tidy installation)
* Datamapper
* Sinatra (only for interface)
