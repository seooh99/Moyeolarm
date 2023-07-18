package com.ssafy.moyeolam.domain.alarmgroup.domain;

import com.ssafy.moyeolam.domain.BaseTimeEntity;
import com.ssafy.moyeolam.domain.meta.domain.AlarmMission;
import com.ssafy.moyeolam.domain.meta.domain.AlarmSound;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.time.LocalTime;

@Entity(name = "alarm_group")
@Builder
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class AlarmGroup extends BaseTimeEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "alarm_group_id")
    private Long id;

    @Column
    private LocalTime time;

    @Builder.Default
    @Column
    private Boolean repeat = Boolean.FALSE;

    @Builder.Default
    @Column
    private Boolean lock = Boolean.FALSE;

    @Enumerated(EnumType.STRING)
    private AlarmMission alarmMission;

    @Enumerated(EnumType.STRING)
    private AlarmSound alarmSound;
}
