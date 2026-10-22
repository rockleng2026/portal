package com.kaixin.user

import com.kaixin.utils.Matchers
import com.kaixin.member.UserObj
import com.kaixin.member.AuthSession
import com.kaixin.utils.KaiXinUtils
import com.qq.sns.commons.Statuses_API
import com.qq.sns.beans.OAuth
import com.qq.sns.utils.OAuthClient
import java.awt.Desktop
import com.qq.sns.config.Config
import com.qq.sns.utils.impl.SyncHttpClient
import org.apache.http.client.methods.HttpGet
import org.apache.http.HttpResponse
import org.apache.http.impl.client.DefaultHttpClient
import org.apache.http.client.HttpClient
import org.apache.http.HttpEntity
import com.qq.sns.beans.Account
import com.kaixin.utils.sys.DateUtils

class ConnectController {
  

    static OAuth oauth = new OAuth(Config.appKey, Config.appSecret, Config.callBackURL); // 初始化OAuth请求令牌
    static OAuthClient authClient = new OAuthClient();// OAuth 认证对象

    /*
      * 采用QQ连接登陆
    */
    def qqlogin = {
        oauth = authClient.requestToken(oauth);
        if (oauth.getStatus() == 1) {
            render("Request Token 授权失败！");
            return;
        } else {
            String url = Config.authUrl + "?oauth_token=" + oauth.getOauth_token() + "&oauth_consumer_key=" + Config.appKey + "&oauth_callback=" + Config.callBackURL;
            redirect(url: url)
        }
    }
    //qq连接成功
    def qqLoginOK = {
        try {
            oauth.setOauth_vericode(params?.oauth_vericode);
            oauth = authClient.accessToken(oauth);
            if (oauth.getStatus() == 2) {
                render("Access Token 授权失败！");
                return;
            } else {
                redirect(action:"qqLoginBind")
            }
        } catch (Exception e) {
            redirect(uri: "/")
            return
        }
    }
    //qq连接绑定
     def qqLoginBind={
          Account ac= authClient.getAccount(oauth);
               session.setAttribute(Config.QQ_USER_SESSION_NAME, ac);
                def connectMember = Connect.findByOpenID(ac.getName());
                if (connectMember) {
                    Member user = connectMember.member;
                    loginSession(user);
                    return redirect(uri: "/")
                }

                [uid: ac.getName(), name: ac.getNick(), headUrl: ac.getHead()]
     }
   
    def connectBindLogin = {
        def loginUser = params.loginUser
        def password = params.password
        Account ac= (Account)session.getAttribute(Config.QQ_USER_SESSION_NAME);
        def connectMember = Connect.findByOpenID(ac.getName());
        Member user
        if (connectMember) {
            user = connectMember.member;
            loginSession(user);
            return redirect(uri: "/")
        } else {
            user = findMember(loginUser, password)
            new Connect(member: user, openID: ac.getName(),connectWeb:"qq").save();
        }

        if (user) {
            loginSession(user);
            redirect(uri: "/")
            return
        } else {

            flash.message = "<img src='/images/error.png' align='absmiddle'>&nbsp;&nbsp;用户名或密码错误。";
            redirect(action: 'qqLoginBind')
            return
        }


    }



}
