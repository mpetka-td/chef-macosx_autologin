actions :enable, :disable
default_action :enable

attribute :username, kind_of: String, name_attribute: true
attribute :password, kind_of: [String, NilClass]
attribute :restart_loginwindow, kind_of: [TrueClass, FalseClass], default: false

attribute :sensitive, kind_of: [TrueClass, FalseClass] # , default: true - see initialize below

# Chef will override sensitive back to its global value, so set default to true in init
def initialize(*args)
  super
  @sensitive = true
end
