#
# This class is automatically generated by mig. DO NOT EDIT THIS FILE.
# This class implements a Python interface to the 'TPIoT'
# message type.
#

import tinyos.message.Message

# The default size of this message type in bytes.
DEFAULT_MESSAGE_SIZE = 8

# The Active Message type associated with this message.
AM_TYPE = 7

class TPIoT(tinyos.message.Message.Message):
    # Create a new TPIoT of size 8.
    def __init__(self, data="", addr=None, gid=None, base_offset=0, data_length=8):
        tinyos.message.Message.Message.__init__(self, data, addr, gid, base_offset, data_length)
        self.amTypeSet(AM_TYPE)
    
    # Get AM_TYPE
    def get_amType(cls):
        return AM_TYPE
    
    get_amType = classmethod(get_amType)
    
    #
    # Return a String representation of this message. Includes the
    # message type name and the non-indexed field values.
    #
    def __str__(self):
        s = "Message <TPIoT> \n"
        try:
            s += "  [sender_nodeid=0x%x]\n" % (self.get_sender_nodeid())
        except:
            pass
        try:
            s += "  [addressee_nodeid=0x%x]\n" % (self.get_addressee_nodeid())
        except:
            pass
        try:
            s += "  [error=0x%x]\n" % (self.get_error())
        except:
            pass
        try:
            s += "  [data=0x%x]\n" % (self.get_data())
        except:
            pass
        return s

    # Message-type-specific access methods appear below.

    #
    # Accessor methods for field: sender_nodeid
    #   Field type: int
    #   Offset (bits): 0
    #   Size (bits): 16
    #

    #
    # Return whether the field 'sender_nodeid' is signed (False).
    #
    def isSigned_sender_nodeid(self):
        return False
    
    #
    # Return whether the field 'sender_nodeid' is an array (False).
    #
    def isArray_sender_nodeid(self):
        return False
    
    #
    # Return the offset (in bytes) of the field 'sender_nodeid'
    #
    def offset_sender_nodeid(self):
        return (0 / 8)
    
    #
    # Return the offset (in bits) of the field 'sender_nodeid'
    #
    def offsetBits_sender_nodeid(self):
        return 0
    
    #
    # Return the value (as a int) of the field 'sender_nodeid'
    #
    def get_sender_nodeid(self):
        return self.getUIntElement(self.offsetBits_sender_nodeid(), 16, 1)
    
    #
    # Set the value of the field 'sender_nodeid'
    #
    def set_sender_nodeid(self, value):
        self.setUIntElement(self.offsetBits_sender_nodeid(), 16, value, 1)
    
    #
    # Return the size, in bytes, of the field 'sender_nodeid'
    #
    def size_sender_nodeid(self):
        return (16 / 8)
    
    #
    # Return the size, in bits, of the field 'sender_nodeid'
    #
    def sizeBits_sender_nodeid(self):
        return 16
    
    #
    # Accessor methods for field: addressee_nodeid
    #   Field type: int
    #   Offset (bits): 16
    #   Size (bits): 16
    #

    #
    # Return whether the field 'addressee_nodeid' is signed (False).
    #
    def isSigned_addressee_nodeid(self):
        return False
    
    #
    # Return whether the field 'addressee_nodeid' is an array (False).
    #
    def isArray_addressee_nodeid(self):
        return False
    
    #
    # Return the offset (in bytes) of the field 'addressee_nodeid'
    #
    def offset_addressee_nodeid(self):
        return (16 / 8)
    
    #
    # Return the offset (in bits) of the field 'addressee_nodeid'
    #
    def offsetBits_addressee_nodeid(self):
        return 16
    
    #
    # Return the value (as a int) of the field 'addressee_nodeid'
    #
    def get_addressee_nodeid(self):
        return self.getUIntElement(self.offsetBits_addressee_nodeid(), 16, 1)
    
    #
    # Set the value of the field 'addressee_nodeid'
    #
    def set_addressee_nodeid(self, value):
        self.setUIntElement(self.offsetBits_addressee_nodeid(), 16, value, 1)
    
    #
    # Return the size, in bytes, of the field 'addressee_nodeid'
    #
    def size_addressee_nodeid(self):
        return (16 / 8)
    
    #
    # Return the size, in bits, of the field 'addressee_nodeid'
    #
    def sizeBits_addressee_nodeid(self):
        return 16
    
    #
    # Accessor methods for field: error
    #   Field type: int
    #   Offset (bits): 32
    #   Size (bits): 16
    #

    #
    # Return whether the field 'error' is signed (False).
    #
    def isSigned_error(self):
        return False
    
    #
    # Return whether the field 'error' is an array (False).
    #
    def isArray_error(self):
        return False
    
    #
    # Return the offset (in bytes) of the field 'error'
    #
    def offset_error(self):
        return (32 / 8)
    
    #
    # Return the offset (in bits) of the field 'error'
    #
    def offsetBits_error(self):
        return 32
    
    #
    # Return the value (as a int) of the field 'error'
    #
    def get_error(self):
        return self.getUIntElement(self.offsetBits_error(), 16, 1)
    
    #
    # Set the value of the field 'error'
    #
    def set_error(self, value):
        self.setUIntElement(self.offsetBits_error(), 16, value, 1)
    
    #
    # Return the size, in bytes, of the field 'error'
    #
    def size_error(self):
        return (16 / 8)
    
    #
    # Return the size, in bits, of the field 'error'
    #
    def sizeBits_error(self):
        return 16
    
    #
    # Accessor methods for field: data
    #   Field type: int
    #   Offset (bits): 48
    #   Size (bits): 16
    #

    #
    # Return whether the field 'data' is signed (False).
    #
    def isSigned_data(self):
        return False
    
    #
    # Return whether the field 'data' is an array (False).
    #
    def isArray_data(self):
        return False
    
    #
    # Return the offset (in bytes) of the field 'data'
    #
    def offset_data(self):
        return (48 / 8)
    
    #
    # Return the offset (in bits) of the field 'data'
    #
    def offsetBits_data(self):
        return 48
    
    #
    # Return the value (as a int) of the field 'data'
    #
    def get_data(self):
        return self.getUIntElement(self.offsetBits_data(), 16, 1)
    
    #
    # Set the value of the field 'data'
    #
    def set_data(self, value):
        self.setUIntElement(self.offsetBits_data(), 16, value, 1)
    
    #
    # Return the size, in bytes, of the field 'data'
    #
    def size_data(self):
        return (16 / 8)
    
    #
    # Return the size, in bits, of the field 'data'
    #
    def sizeBits_data(self):
        return 16
    
