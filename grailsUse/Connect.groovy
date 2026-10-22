package com.kaixin.user

class Connect {
    Member member
    String openID
    String connectWeb
    static constraints = {
        member()
        openID(maxSize: 200)
        connectWeb(maxSize: 50)
    }
    static mapping = {
        openID index: 'OpenID_Idx,OpenIDAndConnectWeb_Idx'
        connectWeb index: 'ConnectWeb_Idx,OpenIDAndConnectWeb_Idx'
    }
}
