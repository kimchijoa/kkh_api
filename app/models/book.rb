class Book < ApplicationRecord
    has_many :flow_fs, dependent: :delete_all
end
