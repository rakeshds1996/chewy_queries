module ChewyQueries

  class GetQuery

    def search(class_name, type, condition, value, field)
      if type == "text"
        if condition == "equal"
          class_name.query(match_phrase: {"#{field}": value})
        elsif condition == "not equal"
          class_name.query.not(match: {"#{field}": value}).and(class_name.query.not(match: {"#{field}": "null"}))
        elsif condition == "contains"
          class_name.query(regexp: {"#{field}": ".*#{value.downcase}.*"}).or(class_name.query(match_phrase: {"#{field}": value}))
        elsif condition == "does not contain"
          class_name.query.not(regexp: {"#{field}": ".*#{value.downcase}.*"}).and(class_name.query.not(match: {"#{field}": "null"}))
        elsif condition == "starts with"
          class_name.query(regexp: {"#{field}": "#{value.downcase}.*"})
        elsif condition == "does not start with"
          class_name.query.not(regexp: {"#{field}": "#{value.downcase}.*"}).and(class_name.query.not(match: {"#{field}": "null"}))
        elsif condition == "ends with"
          class_name.query(regexp: {"#{field}": ".*#{value.downcase}"})
        elsif condition == "does not end with"
          class_name.query.not(regexp: {"#{field}": ".*#{value.downcase}"}).and(ContactIndex.query.not(match: {"#{field}": "null"}))
        elsif condition == "matches exactly"
          class_name.query(match_phrase: {"#{field}": value})
        end
      elsif type == "number"
        if condition == "Is equal to"
          class_name.query(match: {"#{field}": value})
        elsif condition == "Is not equal to"
          class_name.query.not(match: {"#{field}": value})
        elsif condition == "Is greater than"
          class_name.query(range: {"#{field}": {gt: value}})
        elsif condition == "Is less than"
          class_name.query(range: {"#{field}": {lt: value}}).and(class_name.query.not(match: {"#{field}": 0}))
        elsif condition == "Is provided"
          class_name.query.not(match: {"#{field}": 0})
        elsif condition == "Is not provided"
          class_name.query(match: {"#{field}": 0})
        elsif condition == "Is between"
          class_name.query(range: {"#{field}": {gt: value.first, lt: value.last}})
        end
      elsif type == "date"
        if value.class != Array
          value1 = value.split("T").first
        end
        if condition == "Is before"
          class_name.query(range: {"#{field}": {lt: value1}})
        elsif condition == "Is after"
          class_name.query(range: {"#{field}": {gt: value1}})
        elsif condition == "Is on or before"
          class_name.query(range: {"#{field}": {lte: value1}})
        elsif condition == "Is on or after"
          class_name.query(range: {"#{field}": {gte: value1}})
        elsif condition == "equals"
          class_name.query(match: {"#{field}": value1})
        elsif condition == "does not equal"
          class_name.query.not(match: {"#{field}": value1})
        elsif condition == "Is provided"
          class_name.query.not(match: {"#{field}": 0})
        elsif condition == "Is not provided"
          class_name.query(match: {"#{field}": 0})
        elsif condition == "Is between"
          value1 = value.first.split("T").first
          value2 = value.last.split("T").first
          class_name.query(range: {"#{field}": {gt: value1, lt: value2}})
        end
      end
    end

    def exact_match_search(class_name, field, value)
      class_name.query(match_phrase: {"#{field}": value})
    end

    def partial_search(class_name, field, value)
      class_name.query(regexp: {"#{field}": ".*#{value.downcase}.*"})
    end

    def multiple_field_search(class_name, multiple_field_array, value)
      exact_search = []
      partial_search = []
      multiple_field_array.each do |field|
        exact_search << class_name.query(match_phrase: {"#{field}": value})
        partial_search << class_name.query(regexp: {"#{field}": ".*#{value.downcase}.*"})
      end
      search = exact_search + partial_search
      return search.uniq
    end

  end
end