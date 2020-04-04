module Mongoid
  module Batches
    def find_each(batch_size = 1000)
      return to_enum(:find_each, batch_size) unless block_given?

      find_in_batches(batch_size) do |documents|
        documents.each { |document| yield document }
      end
    end

    def find_in_batches(batch_size = 1000)
      return to_enum(:find_in_batches, batch_size) unless block_given?

      documents = self.limit(batch_size).asc(:id).to_a
      while documents.any?
        documents_size = documents.size
        primary_key_offset = documents.last.id

        yield documents

        break if documents_size < batch_size
        documents = self.gt(id: primary_key_offset).limit(batch_size).asc(:id).to_a
      end
    end
  end
end

Mongoid::Criteria.include Mongoid::Batches