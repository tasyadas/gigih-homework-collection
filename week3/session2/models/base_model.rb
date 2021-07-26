class BaseModel
    def table_name
        raise NotImplementedError, "You have to define the table name"
    end

    def save
        
    end
end