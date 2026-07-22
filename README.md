# fastpath

Version: `1.0.0`

`fastpath`는 `docs/plans` 아래 계획 문서를 토큰 절약형 구조로 정리하는 Codex 스킬입니다. 정확한 task를 알 때는 상위 인덱스보다 해당 task를 먼저 찾아 제한된 heading 구간만 읽고, task가 불명확할 때만 인덱스 탐색을 사용합니다.

## 설치 방법

Codex에서 `skill-installer`를 사용해 이 저장소의 스킬 폴더를 설치합니다.

```text
$skill-installer install https://github.com/sohay19/fastpath/tree/main/fastpath
```

설치 후 Codex를 재시작하거나 새 스레드에서 스킬을 사용하세요.

## 사용법

새 프로젝트나 기존 프로젝트에 `docs/plans` 규칙을 적용하려면 아래처럼 요청합니다.

```text
$fastpath init
```

새 계획 문서를 작성할 때도 사용할 수 있습니다.

```text
$fastpath
결제 마이그레이션 계획을 docs/plans에 작성해줘.
```

기존 `docs/plans` 문서가 스킬 구조와 다르면 바로 수정하지 않고, 현재 구조를 요약한 뒤 사용자에게 재구성 여부를 먼저 묻습니다.

## 기본 동작

- 정확한 task 경로, id, 제목을 알면 `SNAPSHOTS.md` 또는 직접 링크에서 해당 task로 이동해 필요한 section만 읽습니다.
- task가 불명확할 때만 `docs/plans/README.md`와 선택한 plan index를 순서대로 탐색합니다.
- `SNAPSHOTS.md`는 objective, current/next task, blockers, latest verification, archive link를 담는 현재 상태의 기준 문서입니다.
- 기존 `HANDOFF.md`가 있으면 보존하고 `SNAPSHOTS.md`와 current task 링크를 담은 짧은 호환 메모만 갱신합니다.
- 필요한 상태를 모두 확인하면 탐색을 중단하고 완료 이력, 이웃 task, phase overview와 반복된 프로젝트 지침을 읽지 않습니다.
- 각 계획은 `docs/plans/<plan-name>/` 아래에 둡니다.
- 각 계획 폴더는 `README.md`, `active/`, `completed/`를 가집니다.
- `README.md`는 `Current task`, `Next task`, `Title`, `Progress`, `Summary`를 관리합니다.
- 정확한 task id나 제목을 알면 해당 heading부터 다음 동급 heading 직전까지만 읽습니다.
- 세부 문서가 400줄 또는 task heading 10개를 넘으면 관련 task 5~10개 단위 분할을 권장합니다.
- 기존 큰 문서는 사용자 승인 전 자동 분할하지 않고 section fast path를 사용합니다.
- 미완료 문서는 `active/`, 실제 완료 문서는 `completed/`에 둡니다.
- 본문 언어는 사용자 요청 언어를 따르고, 별도 요청이 없으면 기존 프로젝트 문서 언어를 따릅니다.
- 폴더명과 파일명은 영어 kebab-case를 권장합니다.

## 저장소 구조

```text
fastpath/
  SKILL.md
  agents/
    openai.yaml
  references/
    init-and-migration.md
    language-policy.md
    plan-contract.md
```
