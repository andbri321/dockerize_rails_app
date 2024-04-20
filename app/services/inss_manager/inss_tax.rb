# frozen_string_literal: true

module InssManager
  # InssTax service
  class InssTax < ApplicationService
    def initialize(salary)
      @salary = salary.to_d
    end

    def discount
      sum_discount
    end

    def salary_tax
      "#{tax_category[1] * 100}%"
    end

    private

    def tax_category
      if @salary <= 1045.00
        [1, 0.075]
      elsif @salary.between?(1045.01, 2089.60)
        [2, 0.09]
      elsif @salary.between?(2089.61, 3134.40)
        [3, 0.12]
      else
        [4, 0.14]
      end
    end

    def sum_discount
      # TODO, precisao de 2 digitos ta trazendo o valor diferente do exemplo, devo mudar pra precisao de 3 digitos
      # InssManager::InssTax.new(3000).discount
      # retorna 281.64 e no teste diz que era pra ser 281.62
      case tax_category[0]
      when 1
        sum_category1
      when 2
        sum_category2
      when 3
        sum_category3
      else
        sum_category4
      end
    end

    def sum_category1
      (@salary * 0.075).round(2)
    end

    def sum_category2
      cat1 = (1045 * 0.075).round(2)
      cat2 = ((@salary - 1045.00) * 0.09).round(2)
      cat1 + cat2
    end

    def sum_category3
      cat1 = (1045.00 * 0.075).round(2)
      cat2 = ((2089.60 - 1045.00) * 0.09).round(2)
      cat3 = ((@salary - 2089.60) * 0.12).round(2)
      cat1 + cat2 + cat3
    end

    def sum_category4
      cat1 = (1045.00 * 0.075).round(2)
      cat2 = ((2089.60 - 1045.00) * 0.09).round(2)
      cat3 = ((3134.40 - 2089.60) * 0.12).round(2)
      cat4 = sum_last_category
      cat1 + cat2 + cat3 + cat4
    end

    def sum_last_category
      if @salary <= 6101.06
        ((@salary - 3134.40) * 0.14).round(2)
      else
        ((6101.06 - 3134.40) * 0.14).round(2)
      end
    end
  end
end
