-- place in ~/.config/wireshark/plugins/

local p_xrce_dds = Proto("xrce-dds", "XRCE-DDS");
local p_xrce_dds_header = Proto("xrce-dds-header", "Header");
local p_xrce_dds_submessage = Proto("xrce-dds-submessage", "Submessage");

local f_sessionId = ProtoField.uint8("xrce-dds.sessionId", "sessionId", base.HEX)
local f_streamId = ProtoField.uint8("xrce-dds.streamId", "streamId", base.HEX)
local f_sequenceNr = ProtoField.uint16("xrce-dds.sequenceNr", "sequenceNr", base.DEC)
local f_clientKey = ProtoField.uint32("xrce-dds.clientKey", "clientKey", base.HEX)

local f_submessageId = ProtoField.uint8("xrce-dds.submessageId", "submessageId", base.HEX)
local f_flags = ProtoField.uint8("xrce-dds.flags", "flags", base.HEX)
local f_submessageLength = ProtoField.uint16("xrce-dds.submessageLength", "submessageLength", base.HEX)

local f_dir = ProtoField.uint8("multi.direction", "Direction", base.DEC, { [1] = "incoming", [0] = "outgoing"})
local f_text = ProtoField.string("multi.text", "Text")

p_xrce_dds_header.fields = { f_sessionId, f_streamId, f_sequenceNr, f_clientKey } 
p_xrce_dds_submessage.fields = { f_submessageId, f_flags, f_submessageLength } 

-- p_xrce_dds.fields = { f_sessionId, f_streamId, f_sequenceNr, f_dir, f_text }

local data_dis = Dissector.get("data")
local SUBMESSAGE_ID =  {
    [0] = "CREATE_CLIENT",
    [1] = "CREATE",
    [2] = "GET_INFO",
    [3] = "DELETE_ID",
    [4] = "STATUS_AGENT",
    [5] = "STATUS",
    [6] = "INFO",
    [7] = "WRITE_DATA",
    [8] = "READ_DATA",
    [9] = "DATA",
    [10] = "ACKNACK",
    [11] = "HEARTBEAT",
    [12] = "RESET",
    [13] = "FRAGMENT",
    [14] = "TIMESTAMP",
    [15] = "TIMESTAMP_REPLY",
    [255] = "PERFORMANCE",
}

Dissector.list()

function p_xrce_dds.dissector(buf, pkt, tree)
        pkt.cols.protocol = "XRCE-DDS"

        if buf(0,4):string() == "RTPS" then
            return 0
        end

        local len = 0
        local subtree = tree:add(p_xrce_dds, buf())
        local header = subtree:add(p_xrce_dds_header, buf())
        header:add(f_sessionId, buf(0,1))
        header:add(f_streamId, buf(1,1))
        header:add(f_sequenceNr, buf(2,2))
        local sessionId = buf(4,4):uint()
        if sessionId <= 127 then
            subtree:add(f_clientKey, buf(4,4))
            len = 8
        else
            len = 4
        end

        local session_id = buf(0,1):uint()

        local submessage = subtree:add(p_xrce_dds_submessage, buf())
        local submessage_id = buf(len,1):uint()
        submessage:add(f_submessageId, buf(len, 1)):append_text(" (" .. SUBMESSAGE_ID[submessage_id] .. ")")
        len = len + 1

end


local udp_encap_table = DissectorTable.get("udp.port")
udp_encap_table:add(2018, p_xrce_dds)
udp_encap_table:add(7400, p_xrce_dds)
