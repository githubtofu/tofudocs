void EDPSimple::assignRemoteEndpoints(
        const ParticipantProxyData& pdata,
        bool assign_secure_endpoints)
{
    EPROSIMA_LOG_INFO(RTPS_EDP, "New DPD received, adding remote endpoints to our SimpleEDP endpoints");
    const NetworkFactory& network = mp_RTPSParticipant->network_factory();
    uint32_t endp = pdata.m_availableBuiltinEndpoints;
    uint32_t auxendp;
	// check avoid_builtin_multicast
    bool use_multicast_locators = !mp_PDP->getRTPSParticipant()->get_attributes().builtin.avoid_builtin_multicast ||
            pdata.metatraffic_locators.unicast.empty();

    auto temp_reader_proxy_data = get_temporary_reader_proxies_pool().get();


