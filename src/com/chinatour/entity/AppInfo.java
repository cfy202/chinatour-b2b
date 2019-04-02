package com.chinatour.entity;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;
import lombok.EqualsAndHashCode;


@Data
@EqualsAndHashCode(callSuper = false)
public class AppInfo {
	@JsonProperty
    private long id;
	@JsonProperty
    private String appToken;
	@JsonProperty
    private String consumerKey;
	@JsonProperty
    private String consumerSecret;
    
	public AppInfo(String appToken, String consumerKey, String consumerSecret) {
        this.appToken = appToken;
        this.consumerKey = consumerKey;
        this.consumerSecret = consumerSecret;
    }
}

