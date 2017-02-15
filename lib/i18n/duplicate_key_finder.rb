require_relative "locale_file_walker"

class DuplicateKeyFinder < LocaleFileWalker

  def find_duplicates(document)
    @keys_with_count = Hash.new { 0 }
    handle_document(document)
    @keys_with_count.select { |key, count| count > 1 }.keys
  end

  protected

    def handle_scalar(node, depth, parents)
      super
      @keys_with_count[parents.join('.')] += 1
    end
end
