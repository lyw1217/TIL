# Ubuntu 20.04에 KVM 설치하기

우분투 20.04에 KVM을 설치하는 방법

## Step 1: 가상화 지원 여부 확인

다음 명령어로 프로세서(CPU)가 가상화 기능을 지원하는지 확인합니다.

```shell
$ sudo apt update
$ sudo apt install cpu-checker
$ kvm-ok
```

아래처럼 출력된다면 프로세서가 가상화를 지원하는 것입니다.

```
INFO: /dev/kvm exists
KVM acceleration can be used
```

## Step 2: 요구 패키지 설치

다음 명령어로 KVM 설치에 요구되는 패키지들을 설치합니다.

```shell
$ sudo apt install qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils virtinst virt-manager
```

다음 명령어로 kvm 설치를 확인할 수 있습니다.

```shell
$ kvm --version
```

각 패키지에 대한 설명입니다.

- `qemu-kvm` - KVM 하이퍼바이저에 대한 하드웨어 에뮬레이션을 제공
- `libvirt-daemon-system` - libvirt 데몬을 시스템 서비스로 실행하는 구성 파일
- `libvirt-clients` - 가상화 플랫폼을 관리하기위한 소프트웨어
- `bridge-utils` - 이더넷 브리지를 구성하기위한 명령 줄 도구 세트
- `virtinst` - 가상 머신을 만들기위한 명령 줄 도구 집합
- `virt-manager` - 사용하기 쉬운 GUI 인터페이스와 libvirt를 통해 가상 머신을 관리하기위한 명령 줄 유틸리티


다음 명령어로 `libvirtd`가 정상적으로 실행되었는지 확인할 수 있습니다.

```shell
$ sudo systemctl is-active libvirtd

# Output
active
```

가상 머신을 생성하고 관리하려면 사용자 계정을 "libvirt" 및 "kvm" 그룹에 추가해야 합니다.

아래 명령어를 수행하여 그룹에 추가합니다.

```shell
$ sudo usermod -aG libvirt $USER
$ sudo usermod -aG kvm $USER
```

로그아웃 했다가 다시 로그인해서 그룹이 새로 고쳐지도록 합니다.

## VM 생성 및 실행 방법 1

다음 명령어를 실행해서 Virtual Machine Manager를 실행합니다.

```shell
$ sudo virt-manager
```

## VM 생성 및 실행 방법 2

KVM에서 우분투 20.04 LTS 인스턴스를 시작하려면 다음 명령어를 실행하면 됩니다.

```shell
$ sudo virt-install --name ubuntu-guest --os-variant ubuntu20.04 --vcpus 2 --ram 2048 --location http://ftp.ubuntu.com/ubuntu/dists/focal/main/installer-amd64/ --network bridge=virbr0,model=virtio --graphics none --extra-args='console=ttyS0,115200n8 serial'
```

실행중인 터미널에서 우분투 VM이 실행되며 설치를 진행할 수 있습니다.


### 참고자료

- [https://ubuntu.com/blog/kvm-hyphervisor](https://ubuntu.com/blog/kvm-hyphervisor)
- [https://linuxize.com/post/how-to-install-kvm-on-ubuntu-20-04/](https://linuxize.com/post/how-to-install-kvm-on-ubuntu-20-04/)