module CompScraper
  class Round
    include DataMapper::Resource

    property :id,             Serial
    property :name,           String
    property :number,         Integer,  :index => true
    property :gender,         String,   :nullable => false, :index => true
    property :competition_id, Integer,  :index => true

    belongs_to :competition

    has n, :heats

    def ordered_heats
      repository do
        heats = self.heats.all
      end
      heats
    end

    def identifier
      self.name || "r#{self.number}"
    end

    def to_s
      self.name ? CompScraper::ROUNDS[:"#{self.name}"] : "Round #{self.number}"
    end

    def save_heat_data
      self.heats = fetch_heat_data.collect do |heat|
        h = Heat.create(:number => heat[:heat_number])
        h.competitors = heat[:competitors].collect do |competitor|
          person = {
            :name => competitor[:name],
            :home_country => competitor[:home_country]
          }
          surfer = Surfer.first(person) || Surfer.create(person)
          surfer.competitors.build(
            :place => competitor[:place],
            :points => competitor[:points],
            :singlet_colour => competitor[:singlet_colour]
          )
        end
        h
      end
      self.save
      self.heats.collect { |heat| heat.save_wave_scores }
    end

    def source
      "#{competition.base_url}#{self.gender}#{identifier}.asp"
    end

    private
      def document
        CompScraper::Document.fetch(source)
      end

      def fetch_heat_data
        CompScraper::RoundHeats.fetch_data(document)
      end

  end
end