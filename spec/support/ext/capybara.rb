module Capybara::Node::Finders
  alias :orig_find :find

  def find(*args)
    begin
      orig_find *args
    rescue Capybara::ElementNotFound => e
      session.save_and_open_page
      raise e
    end
  end
end

module Capybara::Node::Matchers
  %w[has has_no].each do |has_has_no|
    alias :"orig_#{has_has_no}_selector?" :"#{has_has_no}_selector?"

    class_eval <<-METH, __FILE__, __LINE__ + 1
      def #{has_has_no}_selector?(*args)
        session.save_and_open_page unless (result = orig_#{has_has_no}_selector?(*args))
        result
      end
    METH
  end
end
