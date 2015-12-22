module Enjoy::ElasticSearch
  extend ActiveSupport::Concern
  included do
    searchkick(
        language: "Russian",
        suggest: ["name"],
        settings: {
            analysis: {
                analyzer: {
                    default_index: {
                        type: "custom",
                        tokenizer: "standard",
                        filter: ["standard", "lowercase", "asciifolding", "searchkick_index_shingle", "searchkick_stemmer", "snowball"]

                        # https://github.com/imotov/elasticsearch-analysis-morphology
                        # filter: ["standard", "lowercase", "asciifolding", "searchkick_index_shingle", "searchkick_stemmer", "snowball", "russian_morphology", "english_morphology"]
                    }
                }
            }
        }
    )

    def search_data
      {
          _id: _id,
          name: name,
          content: SmartExcerpt.strip_tags(content),
      }
    end
  end
end
