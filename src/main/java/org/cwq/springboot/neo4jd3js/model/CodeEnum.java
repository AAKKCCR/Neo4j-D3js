package org.cwq.springboot.neo4jd3js.model;



public enum CodeEnum {
    SUCCESS(0),
    ERROR(1);

    private Integer code;

    private CodeEnum(Integer code) {
        this.code = code;
    }

    public Integer getCode() {
        return this.code;
    }
}
