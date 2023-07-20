package com.ssafy.moyeolam.domain.alarmgroup.domain;

import com.ssafy.moyeolam.domain.BaseTimeEntity;
import com.ssafy.moyeolam.domain.member.domain.Member;
import com.ssafy.moyeolam.domain.meta.converter.AlarmGroupMemberRoleConverter;
import com.ssafy.moyeolam.domain.meta.domain.AlarmGroupMemberRole;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity(name = "alarm_group_member")
@Builder
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class AlarmGroupMember extends BaseTimeEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "alarm_group_member_id")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "member_id")
    private Member member;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "alarm_group_id")
    private AlarmGroup alarmGroup;

    @Convert(converter = AlarmGroupMemberRoleConverter.class)
    private AlarmGroupMemberRole alarmGroupMemberRole;

    @Builder.Default
    @Column
    private Boolean AlarmToggle = Boolean.FALSE;
}
