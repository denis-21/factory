  class Factory
    class << self
      def new(*args, &block)

        Class.new do

          define_method :initialize do |*field|
            args.each_with_index do |val, index|
              instance_variable_set "@#{val}", field[index]
            end
          end

          define_method :method_missing do |meth, *args|
            instance_variable_get "@#{meth}" or raise "#{meth} method missing"
          end

          def [] key
            return instance_variable_get instance_variables[key] if key.kind_of? Integer
            return self.send(key)
          end

          self.class_eval &block if block_given?

        end
      end
    end
  end

User = Factory.new(:name, :sername)
obj = User.new 'Joe', 'Do'
puts obj.name
puts obj[:name]
puts obj.sername
puts obj[0]
puts obj['name']
