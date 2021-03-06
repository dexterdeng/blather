module Blather
class Stanza
class Iq
  NS_IBB = 'http://jabber.org/protocol/ibb'

  # # In-Band Bytestreams Stanza
  #
  # [XEP-0047: In-Band Bytestreams](http://xmpp.org/extensions/xep-0047.html)
  #
  # @handler :ibb_open
  # @handler :ibb_data
  # @handler :ibb_close
  class Ibb < Iq

    # Overrides the parent method to remove open, close and data nodes
    #
    # @see Blather::Stanza#reply
    def reply
      reply = super
      reply.remove_children :open
      reply.remove_children :close
      reply.remove_children :data
      reply
    end

    class Open < Ibb
      register :ibb_open, :open, NS_IBB

      # Find open node
      #
      # @return [Nokogiri::XML::Element]
      def open
        find_first('ns:open', :ns => NS_IBB)
      end

      # Get the sid of the file transfer
      #
      # @return [String]
      def sid
        open['sid']
      end

    end

    class Data < Ibb
      register :ibb_data, :data, NS_IBB

      # Find data node
      #
      # @return [Nokogiri::XML::Element]
      def data
        find_first('ns:data', :ns => NS_IBB)
      end

      # Get the sid of the file transfer
      #
      # @return [String]
      def sid
        data['sid']
      end
    end

    class Close < Ibb
      register :ibb_close, :close, NS_IBB

      # Find close node
      #
      # @return [Nokogiri::XML::Element]
      def close
        find_first('ns:close', :ns => NS_IBB)
      end

      # Get the sid of the file transfer
      #
      # @return [String]
      def sid
        close['sid']
      end
    end
  end
end
end
end