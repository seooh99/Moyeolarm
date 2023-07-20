package com.ssafy.moyeolam.domain.alarmgroup.domain;

import com.ssafy.moyeolam.domain.BaseTimeEntity;
import com.ssafy.moyeolam.domain.member.domain.Member;
import com.ssafy.moyeolam.domain.meta.converter.MatchStatusConverter;
import com.ssafy.moyeolam.domain.meta.domain.MatchStatus;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity(name = "alarm_group_request")
@Builder
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class AlarmGroupRequest extends BaseTimeEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "alarm_group_request_id")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "alarm_group_id")
    private AlarmGroup alarmGroup;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "from_member_id", referencedColumnName = "member_id")
    private Member fromMember;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "to_member_id", referencedColumnName = "member_id")
    private Member toMember;

    @Convert(converter = MatchStatusConverter.class)
    private MatchStatus matchStatus;
}
