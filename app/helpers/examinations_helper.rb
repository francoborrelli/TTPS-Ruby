module ExaminationsHelper
    def time_format(datetime)
        datetime.strftime("%d-%m-%Y") unless datetime.blank?
    end
end
