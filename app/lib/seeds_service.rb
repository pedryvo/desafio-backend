require '#{Rails.root}/test/factories/clients.rb'
require '#{Rails.root}/test/factories/cards.rb'

module SeedsService
  class SampleClients

    def self.run
      u = Factory(:client)
    end
  end
end
