# frozen_string_literal: true

json.array! @msgs, partial: 'msgs/msg', as: :msg
