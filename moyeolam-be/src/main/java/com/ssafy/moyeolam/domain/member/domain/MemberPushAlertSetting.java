package com.ssafy.moyeolam.domain.member.domain;

import com.ssafy.moyeolam.domain.BaseTimeEntity;
import com.ssafy.moyeolam.domain.meta.converter.PushAlertTypeConverter;
import com.ssafy.moyeolam.domain.meta.domain.MetaData;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity(name = "member_push_alert_setting")
@Builder
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class MemberPushAlertSetting extends BaseTimeEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "member_push_alert_setting_id")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "member_id")
    private Member member;

    @Convert(converter = PushAlertTypeConverter.class)
    private MetaData pushAlertType;

    @Builder.Default
    @Column
    private Boolean pushAlertToggle = Boolean.TRUE;



}