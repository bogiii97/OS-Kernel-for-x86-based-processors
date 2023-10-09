
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00007117          	auipc	sp,0x7
    80000004:	3e813103          	ld	sp,1000(sp) # 800073e8 <_GLOBAL_OFFSET_TABLE_+0x40>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	364030ef          	jal	ra,80003380 <start>

0000000080000020 <spin>:
    80000020:	0000006f          	j	80000020 <spin>
	...

0000000080001000 <copy_and_swap>:
# a1 holds expected value
# a2 holds desired value
# a0 holds return value, 0 if successful, !0 otherwise
.global copy_and_swap
copy_and_swap:
    lr.w t0, (a0)          # Load original value.
    80001000:	100522af          	lr.w	t0,(a0)
    bne t0, a1, fail       # Doesn’t match, so fail.
    80001004:	00b29a63          	bne	t0,a1,80001018 <fail>
    sc.w t0, a2, (a0)      # Try to update.
    80001008:	18c522af          	sc.w	t0,a2,(a0)
    bnez t0, copy_and_swap # Retry if store-conditional failed.
    8000100c:	fe029ae3          	bnez	t0,80001000 <copy_and_swap>
    li a0, 0               # Set return to success.
    80001010:	00000513          	li	a0,0
    jr ra                  # Return.
    80001014:	00008067          	ret

0000000080001018 <fail>:
    fail:
    li a0, 1               # Set return to failure.
    80001018:	00100513          	li	a0,1
    8000101c:	00008067          	ret

0000000080001020 <_ZN7_thread13contextSwitchEPNS_7ContextES1_>:
.global _ZN7_thread13contextSwitchEPNS_7ContextES1_
.type _ZN7_thread13contextSwitchEPNS_7ContextES1_, @function
_ZN7_thread13contextSwitchEPNS_7ContextES1_:
    sd ra, 0 * 8(a0)
    80001020:	00153023          	sd	ra,0(a0) # 1000 <_entry-0x7ffff000>
    sd sp, 1 * 8(a0)
    80001024:	00253423          	sd	sp,8(a0)

    ld ra, 0 * 8(a1)
    80001028:	0005b083          	ld	ra,0(a1)
    ld sp, 1 * 8(a1)
    8000102c:	0085b103          	ld	sp,8(a1)

    ret
    80001030:	00008067          	ret
	...

0000000080001040 <_ZN5Riscv14supervisorTrapEv>:
.global _ZN5Riscv14supervisorTrapEv #ovaj simbol je globalan, da bi ova definicija bila vidljiva za deklaraciju u klasi Riscv
.type _ZN5Riscv14supervisorTrapEv, @function  #tip ovog simbola je funkcija
_ZN5Riscv14supervisorTrapEv:

    # push all registers to stack
        addi sp, sp, -256
    80001040:	f0010113          	addi	sp,sp,-256
        csrw sscratch, sp
    80001044:	14011073          	csrw	sscratch,sp
        .irp index, 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
        sd x\index, \index * 8(sp)
        .endr
    80001048:	00013023          	sd	zero,0(sp)
    8000104c:	00113423          	sd	ra,8(sp)
    80001050:	00213823          	sd	sp,16(sp)
    80001054:	00313c23          	sd	gp,24(sp)
    80001058:	02413023          	sd	tp,32(sp)
    8000105c:	02513423          	sd	t0,40(sp)
    80001060:	02613823          	sd	t1,48(sp)
    80001064:	02713c23          	sd	t2,56(sp)
    80001068:	04813023          	sd	s0,64(sp)
    8000106c:	04913423          	sd	s1,72(sp)
    80001070:	04a13823          	sd	a0,80(sp)
    80001074:	04b13c23          	sd	a1,88(sp)
    80001078:	06c13023          	sd	a2,96(sp)
    8000107c:	06d13423          	sd	a3,104(sp)
    80001080:	06e13823          	sd	a4,112(sp)
    80001084:	06f13c23          	sd	a5,120(sp)
    80001088:	09013023          	sd	a6,128(sp)
    8000108c:	09113423          	sd	a7,136(sp)
    80001090:	09213823          	sd	s2,144(sp)
    80001094:	09313c23          	sd	s3,152(sp)
    80001098:	0b413023          	sd	s4,160(sp)
    8000109c:	0b513423          	sd	s5,168(sp)
    800010a0:	0b613823          	sd	s6,176(sp)
    800010a4:	0b713c23          	sd	s7,184(sp)
    800010a8:	0d813023          	sd	s8,192(sp)
    800010ac:	0d913423          	sd	s9,200(sp)
    800010b0:	0da13823          	sd	s10,208(sp)
    800010b4:	0db13c23          	sd	s11,216(sp)
    800010b8:	0fc13023          	sd	t3,224(sp)
    800010bc:	0fd13423          	sd	t4,232(sp)
    800010c0:	0fe13823          	sd	t5,240(sp)
    800010c4:	0ff13c23          	sd	t6,248(sp)

        call _ZN5Riscv20handleSupervisorTrapEv
    800010c8:	004010ef          	jal	ra,800020cc <_ZN5Riscv20handleSupervisorTrapEv>

        # pop all registers from stack
        .irp index, 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
        ld x\index, \index * 8(sp)
        .endr
    800010cc:	00013003          	ld	zero,0(sp)
    800010d0:	00813083          	ld	ra,8(sp)
    800010d4:	01013103          	ld	sp,16(sp)
    800010d8:	01813183          	ld	gp,24(sp)
    800010dc:	02013203          	ld	tp,32(sp)
    800010e0:	02813283          	ld	t0,40(sp)
    800010e4:	03013303          	ld	t1,48(sp)
    800010e8:	03813383          	ld	t2,56(sp)
    800010ec:	04013403          	ld	s0,64(sp)
    800010f0:	04813483          	ld	s1,72(sp)
    800010f4:	05013503          	ld	a0,80(sp)
    800010f8:	05813583          	ld	a1,88(sp)
    800010fc:	06013603          	ld	a2,96(sp)
    80001100:	06813683          	ld	a3,104(sp)
    80001104:	07013703          	ld	a4,112(sp)
    80001108:	07813783          	ld	a5,120(sp)
    8000110c:	08013803          	ld	a6,128(sp)
    80001110:	08813883          	ld	a7,136(sp)
    80001114:	09013903          	ld	s2,144(sp)
    80001118:	09813983          	ld	s3,152(sp)
    8000111c:	0a013a03          	ld	s4,160(sp)
    80001120:	0a813a83          	ld	s5,168(sp)
    80001124:	0b013b03          	ld	s6,176(sp)
    80001128:	0b813b83          	ld	s7,184(sp)
    8000112c:	0c013c03          	ld	s8,192(sp)
    80001130:	0c813c83          	ld	s9,200(sp)
    80001134:	0d013d03          	ld	s10,208(sp)
    80001138:	0d813d83          	ld	s11,216(sp)
    8000113c:	0e013e03          	ld	t3,224(sp)
    80001140:	0e813e83          	ld	t4,232(sp)
    80001144:	0f013f03          	ld	t5,240(sp)
    80001148:	0f813f83          	ld	t6,248(sp)
        addi sp, sp, 256
    8000114c:	10010113          	addi	sp,sp,256


    sret #iz sstatus se uzima info u kom rezimu rada je bio sistem pre ulaska u prekidnu rutinu, i sret instrukcijom se vracamo u taj rezim rada,
    80001150:	10200073          	sret
	...

0000000080001160 <_ZN11InputBuffer17createInputBufferEv>:
#include "../h/inputBuffer.hpp"

InputBuffer* InputBuffer::inputBuffer = nullptr;

void InputBuffer::createInputBuffer() {
    80001160:	fe010113          	addi	sp,sp,-32
    80001164:	00113c23          	sd	ra,24(sp)
    80001168:	00813823          	sd	s0,16(sp)
    8000116c:	00913423          	sd	s1,8(sp)
    80001170:	01213023          	sd	s2,0(sp)
    80001174:	02010413          	addi	s0,sp,32
    void put(char val) override;
    int get() override;

    void* operator new(size_t sz){
        sz = (sz + sizeof(size_t))/MEM_BLOCK_SIZE + (((sz + sizeof(size_t))%MEM_BLOCK_SIZE)==0?0:1);
        return MemoryAllocator::kmem_alloc(sz);
    80001178:	00200513          	li	a0,2
    8000117c:	00002097          	auipc	ra,0x2
    80001180:	fd8080e7          	jalr	-40(ra) # 80003154 <_ZN15MemoryAllocator10kmem_allocEm>
    80001184:	00050493          	mv	s1,a0
    InputBuffer(int cap) : ConsoleBuffer(cap) {}
    80001188:	000015b7          	lui	a1,0x1
    8000118c:	80058593          	addi	a1,a1,-2048 # 800 <_entry-0x7ffff800>
    80001190:	00001097          	auipc	ra,0x1
    80001194:	878080e7          	jalr	-1928(ra) # 80001a08 <_ZN13ConsoleBufferC1Ei>
    80001198:	00006797          	auipc	a5,0x6
    8000119c:	11878793          	addi	a5,a5,280 # 800072b0 <_ZTV11InputBuffer+0x10>
    800011a0:	00f4b023          	sd	a5,0(s1)
    inputBuffer = new InputBuffer(2048);
    800011a4:	00006797          	auipc	a5,0x6
    800011a8:	2a97be23          	sd	s1,700(a5) # 80007460 <_ZN11InputBuffer11inputBufferE>
}
    800011ac:	01813083          	ld	ra,24(sp)
    800011b0:	01013403          	ld	s0,16(sp)
    800011b4:	00813483          	ld	s1,8(sp)
    800011b8:	00013903          	ld	s2,0(sp)
    800011bc:	02010113          	addi	sp,sp,32
    800011c0:	00008067          	ret
    800011c4:	00050913          	mv	s2,a0
    }

    void operator delete(void* arg){
        MemoryAllocator::kmem_free(arg);
    800011c8:	00048513          	mv	a0,s1
    800011cc:	00002097          	auipc	ra,0x2
    800011d0:	078080e7          	jalr	120(ra) # 80003244 <_ZN15MemoryAllocator9kmem_freeEPv>
    800011d4:	00090513          	mv	a0,s2
    800011d8:	00007097          	auipc	ra,0x7
    800011dc:	3c0080e7          	jalr	960(ra) # 80008598 <_Unwind_Resume>

00000000800011e0 <_ZN11InputBuffer17deleteInputBufferEv>:

void InputBuffer::deleteInputBuffer() {
    delete inputBuffer;
    800011e0:	00006517          	auipc	a0,0x6
    800011e4:	28053503          	ld	a0,640(a0) # 80007460 <_ZN11InputBuffer11inputBufferE>
    800011e8:	02050863          	beqz	a0,80001218 <_ZN11InputBuffer17deleteInputBufferEv+0x38>
void InputBuffer::deleteInputBuffer() {
    800011ec:	ff010113          	addi	sp,sp,-16
    800011f0:	00113423          	sd	ra,8(sp)
    800011f4:	00813023          	sd	s0,0(sp)
    800011f8:	01010413          	addi	s0,sp,16
    delete inputBuffer;
    800011fc:	00053783          	ld	a5,0(a0)
    80001200:	0087b783          	ld	a5,8(a5)
    80001204:	000780e7          	jalr	a5
}
    80001208:	00813083          	ld	ra,8(sp)
    8000120c:	00013403          	ld	s0,0(sp)
    80001210:	01010113          	addi	sp,sp,16
    80001214:	00008067          	ret
    80001218:	00008067          	ret

000000008000121c <_ZN11InputBuffer3putEc>:

void InputBuffer::put(char val){
    if(num == cap) return;
    8000121c:	04052703          	lw	a4,64(a0)
    80001220:	00852783          	lw	a5,8(a0)
    80001224:	04f70263          	beq	a4,a5,80001268 <_ZN11InputBuffer3putEc+0x4c>
void InputBuffer::put(char val){
    80001228:	fe010113          	addi	sp,sp,-32
    8000122c:	00113c23          	sd	ra,24(sp)
    80001230:	00813823          	sd	s0,16(sp)
    80001234:	00913423          	sd	s1,8(sp)
    80001238:	02010413          	addi	s0,sp,32
    8000123c:	00050493          	mv	s1,a0
    ConsoleBuffer::put(val);
    80001240:	00000097          	auipc	ra,0x0
    80001244:	6b4080e7          	jalr	1716(ra) # 800018f4 <_ZN13ConsoleBuffer3putEc>
    num++;
    80001248:	0404a783          	lw	a5,64(s1)
    8000124c:	0017879b          	addiw	a5,a5,1
    80001250:	04f4a023          	sw	a5,64(s1)
}
    80001254:	01813083          	ld	ra,24(sp)
    80001258:	01013403          	ld	s0,16(sp)
    8000125c:	00813483          	ld	s1,8(sp)
    80001260:	02010113          	addi	sp,sp,32
    80001264:	00008067          	ret
    80001268:	00008067          	ret

000000008000126c <_ZN11InputBuffer3getEv>:

int InputBuffer::get() {
    8000126c:	fe010113          	addi	sp,sp,-32
    80001270:	00113c23          	sd	ra,24(sp)
    80001274:	00813823          	sd	s0,16(sp)
    80001278:	00913423          	sd	s1,8(sp)
    8000127c:	02010413          	addi	s0,sp,32
    80001280:	00050493          	mv	s1,a0
    int res = ConsoleBuffer::get();
    80001284:	00000097          	auipc	ra,0x0
    80001288:	6fc080e7          	jalr	1788(ra) # 80001980 <_ZN13ConsoleBuffer3getEv>
    num--;
    8000128c:	0404a783          	lw	a5,64(s1)
    80001290:	fff7879b          	addiw	a5,a5,-1
    80001294:	04f4a023          	sw	a5,64(s1)
    return res;
    80001298:	01813083          	ld	ra,24(sp)
    8000129c:	01013403          	ld	s0,16(sp)
    800012a0:	00813483          	ld	s1,8(sp)
    800012a4:	02010113          	addi	sp,sp,32
    800012a8:	00008067          	ret

00000000800012ac <_ZN11InputBufferD1Ev>:
class InputBuffer : public ConsoleBuffer{
    800012ac:	ff010113          	addi	sp,sp,-16
    800012b0:	00113423          	sd	ra,8(sp)
    800012b4:	00813023          	sd	s0,0(sp)
    800012b8:	01010413          	addi	s0,sp,16
    800012bc:	00006797          	auipc	a5,0x6
    800012c0:	ff478793          	addi	a5,a5,-12 # 800072b0 <_ZTV11InputBuffer+0x10>
    800012c4:	00f53023          	sd	a5,0(a0)
    800012c8:	00000097          	auipc	ra,0x0
    800012cc:	578080e7          	jalr	1400(ra) # 80001840 <_ZN13ConsoleBufferD1Ev>
    800012d0:	00813083          	ld	ra,8(sp)
    800012d4:	00013403          	ld	s0,0(sp)
    800012d8:	01010113          	addi	sp,sp,16
    800012dc:	00008067          	ret

00000000800012e0 <_ZN11InputBufferD0Ev>:
    800012e0:	fe010113          	addi	sp,sp,-32
    800012e4:	00113c23          	sd	ra,24(sp)
    800012e8:	00813823          	sd	s0,16(sp)
    800012ec:	00913423          	sd	s1,8(sp)
    800012f0:	02010413          	addi	s0,sp,32
    800012f4:	00050493          	mv	s1,a0
    800012f8:	00006797          	auipc	a5,0x6
    800012fc:	fb878793          	addi	a5,a5,-72 # 800072b0 <_ZTV11InputBuffer+0x10>
    80001300:	00f53023          	sd	a5,0(a0)
    80001304:	00000097          	auipc	ra,0x0
    80001308:	53c080e7          	jalr	1340(ra) # 80001840 <_ZN13ConsoleBufferD1Ev>
        MemoryAllocator::kmem_free(arg);
    8000130c:	00048513          	mv	a0,s1
    80001310:	00002097          	auipc	ra,0x2
    80001314:	f34080e7          	jalr	-204(ra) # 80003244 <_ZN15MemoryAllocator9kmem_freeEPv>
class InputBuffer : public ConsoleBuffer{
    80001318:	01813083          	ld	ra,24(sp)
    8000131c:	01013403          	ld	s0,16(sp)
    80001320:	00813483          	ld	s1,8(sp)
    80001324:	02010113          	addi	sp,sp,32
    80001328:	00008067          	ret

000000008000132c <_Z9mem_allocm>:
#include "../h/syscall_c.hpp"
#include "../h/riscV.hpp"
#include "../lib/console.h"

void* mem_alloc(size_t size){
    if(size <= 0 || size > (uint64)HEAP_END_ADDR - (uint64)HEAP_START_ADDR) return nullptr;
    8000132c:	06050e63          	beqz	a0,800013a8 <_Z9mem_allocm+0x7c>
    80001330:	00006797          	auipc	a5,0x6
    80001334:	0c07b783          	ld	a5,192(a5) # 800073f0 <_GLOBAL_OFFSET_TABLE_+0x48>
    80001338:	0007b783          	ld	a5,0(a5)
    8000133c:	00006717          	auipc	a4,0x6
    80001340:	08c73703          	ld	a4,140(a4) # 800073c8 <_GLOBAL_OFFSET_TABLE_+0x20>
    80001344:	00073703          	ld	a4,0(a4)
    80001348:	40e787b3          	sub	a5,a5,a4
    8000134c:	06a7e263          	bltu	a5,a0,800013b0 <_Z9mem_allocm+0x84>
void* mem_alloc(size_t size){
    80001350:	fe010113          	addi	sp,sp,-32
    80001354:	00113c23          	sd	ra,24(sp)
    80001358:	00813823          	sd	s0,16(sp)
    8000135c:	02010413          	addi	s0,sp,32
    else size = (size + sizeof(size_t))/MEM_BLOCK_SIZE + (((size + sizeof(size_t))%MEM_BLOCK_SIZE)==0?0:1);
    80001360:	00850513          	addi	a0,a0,8
    80001364:	00655793          	srli	a5,a0,0x6
    80001368:	03f57513          	andi	a0,a0,63
    8000136c:	00a03533          	snez	a0,a0
    80001370:	00a78533          	add	a0,a5,a0
    80001374:	fea43423          	sd	a0,-24(s0)
    Riscv::sysCall(0x1,&size, nullptr, nullptr, nullptr);
    80001378:	00000713          	li	a4,0
    8000137c:	00000693          	li	a3,0
    80001380:	00000613          	li	a2,0
    80001384:	fe840593          	addi	a1,s0,-24
    80001388:	00100513          	li	a0,1
    8000138c:	00001097          	auipc	ra,0x1
    80001390:	0e4080e7          	jalr	228(ra) # 80002470 <_ZN5Riscv7sysCallEmPvS0_S0_S0_>
    void* res = nullptr;
    __asm__ ("mv %[res], a0" : [res] "=r"(res));
    80001394:	00050513          	mv	a0,a0
    return res;
}
    80001398:	01813083          	ld	ra,24(sp)
    8000139c:	01013403          	ld	s0,16(sp)
    800013a0:	02010113          	addi	sp,sp,32
    800013a4:	00008067          	ret
    if(size <= 0 || size > (uint64)HEAP_END_ADDR - (uint64)HEAP_START_ADDR) return nullptr;
    800013a8:	00000513          	li	a0,0
    800013ac:	00008067          	ret
    800013b0:	00000513          	li	a0,0
}
    800013b4:	00008067          	ret

00000000800013b8 <_Z8mem_freePv>:

int mem_free(void* addr){
    if(addr == nullptr) return -1;
    800013b8:	04050463          	beqz	a0,80001400 <_Z8mem_freePv+0x48>
int mem_free(void* addr){
    800013bc:	ff010113          	addi	sp,sp,-16
    800013c0:	00113423          	sd	ra,8(sp)
    800013c4:	00813023          	sd	s0,0(sp)
    800013c8:	01010413          	addi	s0,sp,16
    800013cc:	00050593          	mv	a1,a0
    Riscv::sysCall(0x2, addr, nullptr, nullptr, nullptr);
    800013d0:	00000713          	li	a4,0
    800013d4:	00000693          	li	a3,0
    800013d8:	00000613          	li	a2,0
    800013dc:	00200513          	li	a0,2
    800013e0:	00001097          	auipc	ra,0x1
    800013e4:	090080e7          	jalr	144(ra) # 80002470 <_ZN5Riscv7sysCallEmPvS0_S0_S0_>
    uint64 res = 0;
    __asm__ ("mv %[res], a0" : [res] "=r"(res));
    800013e8:	00050513          	mv	a0,a0
    return res;
    800013ec:	0005051b          	sext.w	a0,a0
}
    800013f0:	00813083          	ld	ra,8(sp)
    800013f4:	00013403          	ld	s0,0(sp)
    800013f8:	01010113          	addi	sp,sp,16
    800013fc:	00008067          	ret
    if(addr == nullptr) return -1;
    80001400:	fff00513          	li	a0,-1
}
    80001404:	00008067          	ret

0000000080001408 <_Z13thread_createPP7_threadPFvPvES2_>:

int thread_create(thread_t* handle, void(*start_routine)(void*), void* arg){
    80001408:	fd010113          	addi	sp,sp,-48
    8000140c:	02113423          	sd	ra,40(sp)
    80001410:	02813023          	sd	s0,32(sp)
    80001414:	00913c23          	sd	s1,24(sp)
    80001418:	01213823          	sd	s2,16(sp)
    8000141c:	01313423          	sd	s3,8(sp)
    80001420:	03010413          	addi	s0,sp,48
    80001424:	00050493          	mv	s1,a0
    80001428:	00058913          	mv	s2,a1
    8000142c:	00060993          	mv	s3,a2
    void* stack_size = mem_alloc((uint64)DEFAULT_STACK_SIZE);
    80001430:	00001537          	lui	a0,0x1
    80001434:	00000097          	auipc	ra,0x0
    80001438:	ef8080e7          	jalr	-264(ra) # 8000132c <_Z9mem_allocm>
    8000143c:	00050713          	mv	a4,a0
    Riscv::sysCall(0x11, handle, (void*)start_routine, arg, stack_size);
    80001440:	00098693          	mv	a3,s3
    80001444:	00090613          	mv	a2,s2
    80001448:	00048593          	mv	a1,s1
    8000144c:	01100513          	li	a0,17
    80001450:	00001097          	auipc	ra,0x1
    80001454:	020080e7          	jalr	32(ra) # 80002470 <_ZN5Riscv7sysCallEmPvS0_S0_S0_>
    uint64 res = 0;
    __asm__ ("mv %[res], a0" : [res] "=r"(res));
    80001458:	00050513          	mv	a0,a0
    return res;
}
    8000145c:	0005051b          	sext.w	a0,a0
    80001460:	02813083          	ld	ra,40(sp)
    80001464:	02013403          	ld	s0,32(sp)
    80001468:	01813483          	ld	s1,24(sp)
    8000146c:	01013903          	ld	s2,16(sp)
    80001470:	00813983          	ld	s3,8(sp)
    80001474:	03010113          	addi	sp,sp,48
    80001478:	00008067          	ret

000000008000147c <_Z11thread_exitv>:

int thread_exit(){
    8000147c:	ff010113          	addi	sp,sp,-16
    80001480:	00113423          	sd	ra,8(sp)
    80001484:	00813023          	sd	s0,0(sp)
    80001488:	01010413          	addi	s0,sp,16
    Riscv::sysCall(0x12, nullptr, nullptr, nullptr, nullptr);
    8000148c:	00000713          	li	a4,0
    80001490:	00000693          	li	a3,0
    80001494:	00000613          	li	a2,0
    80001498:	00000593          	li	a1,0
    8000149c:	01200513          	li	a0,18
    800014a0:	00001097          	auipc	ra,0x1
    800014a4:	fd0080e7          	jalr	-48(ra) # 80002470 <_ZN5Riscv7sysCallEmPvS0_S0_S0_>
    uint64 res = 0;
    __asm__ ("mv %[res], a0" : [res] "=r"(res));
    800014a8:	00050513          	mv	a0,a0
    return res;
}
    800014ac:	0005051b          	sext.w	a0,a0
    800014b0:	00813083          	ld	ra,8(sp)
    800014b4:	00013403          	ld	s0,0(sp)
    800014b8:	01010113          	addi	sp,sp,16
    800014bc:	00008067          	ret

00000000800014c0 <_Z15thread_dispatchv>:
void thread_dispatch(){
    800014c0:	ff010113          	addi	sp,sp,-16
    800014c4:	00113423          	sd	ra,8(sp)
    800014c8:	00813023          	sd	s0,0(sp)
    800014cc:	01010413          	addi	s0,sp,16
    Riscv::sysCall(0x13, nullptr, nullptr, nullptr, nullptr);
    800014d0:	00000713          	li	a4,0
    800014d4:	00000693          	li	a3,0
    800014d8:	00000613          	li	a2,0
    800014dc:	00000593          	li	a1,0
    800014e0:	01300513          	li	a0,19
    800014e4:	00001097          	auipc	ra,0x1
    800014e8:	f8c080e7          	jalr	-116(ra) # 80002470 <_ZN5Riscv7sysCallEmPvS0_S0_S0_>
}
    800014ec:	00813083          	ld	ra,8(sp)
    800014f0:	00013403          	ld	s0,0(sp)
    800014f4:	01010113          	addi	sp,sp,16
    800014f8:	00008067          	ret

00000000800014fc <_Z17thread_create_cppPP7_threadPFvPvES2_>:

void thread_create_cpp(thread_t* handle, void(*start_routine)(void*), void* arg){
    800014fc:	fd010113          	addi	sp,sp,-48
    80001500:	02113423          	sd	ra,40(sp)
    80001504:	02813023          	sd	s0,32(sp)
    80001508:	00913c23          	sd	s1,24(sp)
    8000150c:	01213823          	sd	s2,16(sp)
    80001510:	01313423          	sd	s3,8(sp)
    80001514:	03010413          	addi	s0,sp,48
    80001518:	00050493          	mv	s1,a0
    8000151c:	00058913          	mv	s2,a1
    80001520:	00060993          	mv	s3,a2
    void* stack_size = mem_alloc((uint64)DEFAULT_STACK_SIZE);
    80001524:	00001537          	lui	a0,0x1
    80001528:	00000097          	auipc	ra,0x0
    8000152c:	e04080e7          	jalr	-508(ra) # 8000132c <_Z9mem_allocm>
    80001530:	00050713          	mv	a4,a0
    Riscv::sysCall(0x14, handle, (void*)start_routine, arg, stack_size);
    80001534:	00098693          	mv	a3,s3
    80001538:	00090613          	mv	a2,s2
    8000153c:	00048593          	mv	a1,s1
    80001540:	01400513          	li	a0,20
    80001544:	00001097          	auipc	ra,0x1
    80001548:	f2c080e7          	jalr	-212(ra) # 80002470 <_ZN5Riscv7sysCallEmPvS0_S0_S0_>
}
    8000154c:	02813083          	ld	ra,40(sp)
    80001550:	02013403          	ld	s0,32(sp)
    80001554:	01813483          	ld	s1,24(sp)
    80001558:	01013903          	ld	s2,16(sp)
    8000155c:	00813983          	ld	s3,8(sp)
    80001560:	03010113          	addi	sp,sp,48
    80001564:	00008067          	ret

0000000080001568 <_Z12addSchedulerP7_thread>:

void addScheduler(thread_t t){
    80001568:	ff010113          	addi	sp,sp,-16
    8000156c:	00113423          	sd	ra,8(sp)
    80001570:	00813023          	sd	s0,0(sp)
    80001574:	01010413          	addi	s0,sp,16
    80001578:	00050593          	mv	a1,a0
    Riscv::sysCall(0x15, t, nullptr, nullptr, nullptr);
    8000157c:	00000713          	li	a4,0
    80001580:	00000693          	li	a3,0
    80001584:	00000613          	li	a2,0
    80001588:	01500513          	li	a0,21
    8000158c:	00001097          	auipc	ra,0x1
    80001590:	ee4080e7          	jalr	-284(ra) # 80002470 <_ZN5Riscv7sysCallEmPvS0_S0_S0_>
}
    80001594:	00813083          	ld	ra,8(sp)
    80001598:	00013403          	ld	s0,0(sp)
    8000159c:	01010113          	addi	sp,sp,16
    800015a0:	00008067          	ret

00000000800015a4 <_Z8sem_openPP4_semj>:

int sem_open(sem_t* handle, unsigned  init){
    800015a4:	fe010113          	addi	sp,sp,-32
    800015a8:	00113c23          	sd	ra,24(sp)
    800015ac:	00813823          	sd	s0,16(sp)
    800015b0:	02010413          	addi	s0,sp,32
    800015b4:	feb42623          	sw	a1,-20(s0)
    Riscv::sysCall(0x21, handle, &init, nullptr, nullptr);
    800015b8:	00000713          	li	a4,0
    800015bc:	00000693          	li	a3,0
    800015c0:	fec40613          	addi	a2,s0,-20
    800015c4:	00050593          	mv	a1,a0
    800015c8:	02100513          	li	a0,33
    800015cc:	00001097          	auipc	ra,0x1
    800015d0:	ea4080e7          	jalr	-348(ra) # 80002470 <_ZN5Riscv7sysCallEmPvS0_S0_S0_>
    uint64 res = 0;
    __asm__ ("mv %[res], a0" : [res] "=r"(res));
    800015d4:	00050513          	mv	a0,a0
    return res;
}
    800015d8:	0005051b          	sext.w	a0,a0
    800015dc:	01813083          	ld	ra,24(sp)
    800015e0:	01013403          	ld	s0,16(sp)
    800015e4:	02010113          	addi	sp,sp,32
    800015e8:	00008067          	ret

00000000800015ec <_Z9sem_closeP4_sem>:
int sem_close(sem_t handle){
    800015ec:	ff010113          	addi	sp,sp,-16
    800015f0:	00113423          	sd	ra,8(sp)
    800015f4:	00813023          	sd	s0,0(sp)
    800015f8:	01010413          	addi	s0,sp,16
    800015fc:	00050593          	mv	a1,a0
    Riscv::sysCall(0x22, handle, nullptr, nullptr, nullptr);
    80001600:	00000713          	li	a4,0
    80001604:	00000693          	li	a3,0
    80001608:	00000613          	li	a2,0
    8000160c:	02200513          	li	a0,34
    80001610:	00001097          	auipc	ra,0x1
    80001614:	e60080e7          	jalr	-416(ra) # 80002470 <_ZN5Riscv7sysCallEmPvS0_S0_S0_>
    uint64 res = 0;
    __asm__ ("mv %[res], a0" : [res] "=r"(res));
    80001618:	00050513          	mv	a0,a0
    return res;
}
    8000161c:	0005051b          	sext.w	a0,a0
    80001620:	00813083          	ld	ra,8(sp)
    80001624:	00013403          	ld	s0,0(sp)
    80001628:	01010113          	addi	sp,sp,16
    8000162c:	00008067          	ret

0000000080001630 <_Z8sem_waitP4_sem>:
int sem_wait(sem_t id){
    80001630:	ff010113          	addi	sp,sp,-16
    80001634:	00113423          	sd	ra,8(sp)
    80001638:	00813023          	sd	s0,0(sp)
    8000163c:	01010413          	addi	s0,sp,16
    80001640:	00050593          	mv	a1,a0
    Riscv::sysCall(0x23, id, nullptr, nullptr, nullptr);
    80001644:	00000713          	li	a4,0
    80001648:	00000693          	li	a3,0
    8000164c:	00000613          	li	a2,0
    80001650:	02300513          	li	a0,35
    80001654:	00001097          	auipc	ra,0x1
    80001658:	e1c080e7          	jalr	-484(ra) # 80002470 <_ZN5Riscv7sysCallEmPvS0_S0_S0_>
    uint64 res = 0;
    __asm__ ("mv %[res], a0" : [res] "=r"(res));
    8000165c:	00050513          	mv	a0,a0
    return res;
}
    80001660:	0005051b          	sext.w	a0,a0
    80001664:	00813083          	ld	ra,8(sp)
    80001668:	00013403          	ld	s0,0(sp)
    8000166c:	01010113          	addi	sp,sp,16
    80001670:	00008067          	ret

0000000080001674 <_Z10sem_signalP4_sem>:
int sem_signal(sem_t id){
    80001674:	ff010113          	addi	sp,sp,-16
    80001678:	00113423          	sd	ra,8(sp)
    8000167c:	00813023          	sd	s0,0(sp)
    80001680:	01010413          	addi	s0,sp,16
    80001684:	00050593          	mv	a1,a0
    Riscv::sysCall(0x24, id, nullptr, nullptr, nullptr);
    80001688:	00000713          	li	a4,0
    8000168c:	00000693          	li	a3,0
    80001690:	00000613          	li	a2,0
    80001694:	02400513          	li	a0,36
    80001698:	00001097          	auipc	ra,0x1
    8000169c:	dd8080e7          	jalr	-552(ra) # 80002470 <_ZN5Riscv7sysCallEmPvS0_S0_S0_>
    uint64 res = 0;
    __asm__ ("mv %[res], a0" : [res] "=r"(res));
    800016a0:	00050513          	mv	a0,a0
    return res;
}
    800016a4:	0005051b          	sext.w	a0,a0
    800016a8:	00813083          	ld	ra,8(sp)
    800016ac:	00013403          	ld	s0,0(sp)
    800016b0:	01010113          	addi	sp,sp,16
    800016b4:	00008067          	ret

00000000800016b8 <_Z10time_sleepm>:

int time_sleep(time_t time){
    800016b8:	fe010113          	addi	sp,sp,-32
    800016bc:	00113c23          	sd	ra,24(sp)
    800016c0:	00813823          	sd	s0,16(sp)
    800016c4:	02010413          	addi	s0,sp,32
    800016c8:	fea43423          	sd	a0,-24(s0)
    Riscv::sysCall(0x31, &time, nullptr, nullptr, nullptr);
    800016cc:	00000713          	li	a4,0
    800016d0:	00000693          	li	a3,0
    800016d4:	00000613          	li	a2,0
    800016d8:	fe840593          	addi	a1,s0,-24
    800016dc:	03100513          	li	a0,49
    800016e0:	00001097          	auipc	ra,0x1
    800016e4:	d90080e7          	jalr	-624(ra) # 80002470 <_ZN5Riscv7sysCallEmPvS0_S0_S0_>
    uint64 res = 0;
    __asm__ ("mv %[res], a0" : [res] "=r"(res));
    800016e8:	00050513          	mv	a0,a0
    return res;
}
    800016ec:	0005051b          	sext.w	a0,a0
    800016f0:	01813083          	ld	ra,24(sp)
    800016f4:	01013403          	ld	s0,16(sp)
    800016f8:	02010113          	addi	sp,sp,32
    800016fc:	00008067          	ret

0000000080001700 <_Z4getcv>:

char getc(){
    80001700:	ff010113          	addi	sp,sp,-16
    80001704:	00113423          	sd	ra,8(sp)
    80001708:	00813023          	sd	s0,0(sp)
    8000170c:	01010413          	addi	s0,sp,16
    Riscv::sysCall(0x41, nullptr, nullptr, nullptr, nullptr);
    80001710:	00000713          	li	a4,0
    80001714:	00000693          	li	a3,0
    80001718:	00000613          	li	a2,0
    8000171c:	00000593          	li	a1,0
    80001720:	04100513          	li	a0,65
    80001724:	00001097          	auipc	ra,0x1
    80001728:	d4c080e7          	jalr	-692(ra) # 80002470 <_ZN5Riscv7sysCallEmPvS0_S0_S0_>
    uint64 res = 0;
    __asm__ ("mv %[res], a0" : [res] "=r"(res));
    8000172c:	00050513          	mv	a0,a0
    return res;
}
    80001730:	0ff57513          	andi	a0,a0,255
    80001734:	00813083          	ld	ra,8(sp)
    80001738:	00013403          	ld	s0,0(sp)
    8000173c:	01010113          	addi	sp,sp,16
    80001740:	00008067          	ret

0000000080001744 <_Z4putcc>:

void putc(char c){
    80001744:	fe010113          	addi	sp,sp,-32
    80001748:	00113c23          	sd	ra,24(sp)
    8000174c:	00813823          	sd	s0,16(sp)
    80001750:	02010413          	addi	s0,sp,32
    80001754:	fea407a3          	sb	a0,-17(s0)
    Riscv::sysCall(0x42, &c, nullptr, nullptr, nullptr);
    80001758:	00000713          	li	a4,0
    8000175c:	00000693          	li	a3,0
    80001760:	00000613          	li	a2,0
    80001764:	fef40593          	addi	a1,s0,-17
    80001768:	04200513          	li	a0,66
    8000176c:	00001097          	auipc	ra,0x1
    80001770:	d04080e7          	jalr	-764(ra) # 80002470 <_ZN5Riscv7sysCallEmPvS0_S0_S0_>
}
    80001774:	01813083          	ld	ra,24(sp)
    80001778:	01013403          	ld	s0,16(sp)
    8000177c:	02010113          	addi	sp,sp,32
    80001780:	00008067          	ret

0000000080001784 <_Z8userModev>:

void userMode(){
    80001784:	ff010113          	addi	sp,sp,-16
    80001788:	00113423          	sd	ra,8(sp)
    8000178c:	00813023          	sd	s0,0(sp)
    80001790:	01010413          	addi	s0,sp,16
    Riscv::sysCall(0x50, nullptr, nullptr, nullptr, nullptr);
    80001794:	00000713          	li	a4,0
    80001798:	00000693          	li	a3,0
    8000179c:	00000613          	li	a2,0
    800017a0:	00000593          	li	a1,0
    800017a4:	05000513          	li	a0,80
    800017a8:	00001097          	auipc	ra,0x1
    800017ac:	cc8080e7          	jalr	-824(ra) # 80002470 <_ZN5Riscv7sysCallEmPvS0_S0_S0_>

}
    800017b0:	00813083          	ld	ra,8(sp)
    800017b4:	00013403          	ld	s0,0(sp)
    800017b8:	01010113          	addi	sp,sp,16
    800017bc:	00008067          	ret

00000000800017c0 <_Z10kernelModev>:

void kernelMode(){
    800017c0:	ff010113          	addi	sp,sp,-16
    800017c4:	00113423          	sd	ra,8(sp)
    800017c8:	00813023          	sd	s0,0(sp)
    800017cc:	01010413          	addi	s0,sp,16
    Riscv::sysCall(0x51, nullptr, nullptr, nullptr, nullptr);
    800017d0:	00000713          	li	a4,0
    800017d4:	00000693          	li	a3,0
    800017d8:	00000613          	li	a2,0
    800017dc:	00000593          	li	a1,0
    800017e0:	05100513          	li	a0,81
    800017e4:	00001097          	auipc	ra,0x1
    800017e8:	c8c080e7          	jalr	-884(ra) # 80002470 <_ZN5Riscv7sysCallEmPvS0_S0_S0_>
    800017ec:	00813083          	ld	ra,8(sp)
    800017f0:	00013403          	ld	s0,0(sp)
    800017f4:	01010113          	addi	sp,sp,16
    800017f8:	00008067          	ret

00000000800017fc <_Z6getIdCP7_thread>:
    800017fc:	ff010113          	addi	sp,sp,-16
    80001800:	00113423          	sd	ra,8(sp)
    80001804:	00813023          	sd	s0,0(sp)
    80001808:	01010413          	addi	s0,sp,16
    8000180c:	00050593          	mv	a1,a0
    80001810:	00000713          	li	a4,0
    80001814:	00000693          	li	a3,0
    80001818:	00000613          	li	a2,0
    8000181c:	06000513          	li	a0,96
    80001820:	00001097          	auipc	ra,0x1
    80001824:	c50080e7          	jalr	-944(ra) # 80002470 <_ZN5Riscv7sysCallEmPvS0_S0_S0_>
    80001828:	00050513          	mv	a0,a0
    8000182c:	0005051b          	sext.w	a0,a0
    80001830:	00813083          	ld	ra,8(sp)
    80001834:	00013403          	ld	s0,0(sp)
    80001838:	01010113          	addi	sp,sp,16
    8000183c:	00008067          	ret

0000000080001840 <_ZN13ConsoleBufferD1Ev>:
    _sem::ksem_open(&spaceAvailable,_cap);
    _sem::ksem_open(&mutexHead, 1);
    _sem::ksem_open(&mutexTail, 1);
}

ConsoleBuffer::~ConsoleBuffer() {
    80001840:	fe010113          	addi	sp,sp,-32
    80001844:	00113c23          	sd	ra,24(sp)
    80001848:	00813823          	sd	s0,16(sp)
    8000184c:	00913423          	sd	s1,8(sp)
    80001850:	02010413          	addi	s0,sp,32
    80001854:	00050493          	mv	s1,a0
    80001858:	00006797          	auipc	a5,0x6
    8000185c:	a9078793          	addi	a5,a5,-1392 # 800072e8 <_ZTV13ConsoleBuffer+0x10>
    80001860:	00f53023          	sd	a5,0(a0) # 1000 <_entry-0x7ffff000>
    MemoryAllocator::kmem_free(buffer);
    80001864:	01053503          	ld	a0,16(a0)
    80001868:	00002097          	auipc	ra,0x2
    8000186c:	9dc080e7          	jalr	-1572(ra) # 80003244 <_ZN15MemoryAllocator9kmem_freeEPv>
    _sem::ksem_close(itemAvailable);
    80001870:	0284b503          	ld	a0,40(s1)
    80001874:	00000097          	auipc	ra,0x0
    80001878:	488080e7          	jalr	1160(ra) # 80001cfc <_ZN4_sem10ksem_closeEPS_>
    _sem::ksem_close(spaceAvailable);
    8000187c:	0204b503          	ld	a0,32(s1)
    80001880:	00000097          	auipc	ra,0x0
    80001884:	47c080e7          	jalr	1148(ra) # 80001cfc <_ZN4_sem10ksem_closeEPS_>
    _sem::ksem_close(mutexTail);
    80001888:	0384b503          	ld	a0,56(s1)
    8000188c:	00000097          	auipc	ra,0x0
    80001890:	470080e7          	jalr	1136(ra) # 80001cfc <_ZN4_sem10ksem_closeEPS_>
    _sem::ksem_close(mutexHead);
    80001894:	0304b503          	ld	a0,48(s1)
    80001898:	00000097          	auipc	ra,0x0
    8000189c:	464080e7          	jalr	1124(ra) # 80001cfc <_ZN4_sem10ksem_closeEPS_>


}
    800018a0:	01813083          	ld	ra,24(sp)
    800018a4:	01013403          	ld	s0,16(sp)
    800018a8:	00813483          	ld	s1,8(sp)
    800018ac:	02010113          	addi	sp,sp,32
    800018b0:	00008067          	ret

00000000800018b4 <_ZN13ConsoleBufferD0Ev>:
ConsoleBuffer::~ConsoleBuffer() {
    800018b4:	fe010113          	addi	sp,sp,-32
    800018b8:	00113c23          	sd	ra,24(sp)
    800018bc:	00813823          	sd	s0,16(sp)
    800018c0:	00913423          	sd	s1,8(sp)
    800018c4:	02010413          	addi	s0,sp,32
    800018c8:	00050493          	mv	s1,a0
}
    800018cc:	00000097          	auipc	ra,0x0
    800018d0:	f74080e7          	jalr	-140(ra) # 80001840 <_ZN13ConsoleBufferD1Ev>
        sz = (sz + sizeof(size_t))/MEM_BLOCK_SIZE + (((sz + sizeof(size_t))%MEM_BLOCK_SIZE)==0?0:1);
        return MemoryAllocator::kmem_alloc(sz);
    }

    void operator delete(void* arg){
        MemoryAllocator::kmem_free(arg);
    800018d4:	00048513          	mv	a0,s1
    800018d8:	00002097          	auipc	ra,0x2
    800018dc:	96c080e7          	jalr	-1684(ra) # 80003244 <_ZN15MemoryAllocator9kmem_freeEPv>
    800018e0:	01813083          	ld	ra,24(sp)
    800018e4:	01013403          	ld	s0,16(sp)
    800018e8:	00813483          	ld	s1,8(sp)
    800018ec:	02010113          	addi	sp,sp,32
    800018f0:	00008067          	ret

00000000800018f4 <_ZN13ConsoleBuffer3putEc>:

void ConsoleBuffer::put(char val) {
    800018f4:	fe010113          	addi	sp,sp,-32
    800018f8:	00113c23          	sd	ra,24(sp)
    800018fc:	00813823          	sd	s0,16(sp)
    80001900:	00913423          	sd	s1,8(sp)
    80001904:	01213023          	sd	s2,0(sp)
    80001908:	02010413          	addi	s0,sp,32
    8000190c:	00050493          	mv	s1,a0
    80001910:	00058913          	mv	s2,a1
    _sem::kwait(spaceAvailable);
    80001914:	02053503          	ld	a0,32(a0)
    80001918:	00000097          	auipc	ra,0x0
    8000191c:	230080e7          	jalr	560(ra) # 80001b48 <_ZN4_sem5kwaitEPS_>

    _sem::kwait(mutexTail);
    80001920:	0384b503          	ld	a0,56(s1)
    80001924:	00000097          	auipc	ra,0x0
    80001928:	224080e7          	jalr	548(ra) # 80001b48 <_ZN4_sem5kwaitEPS_>
    buffer[tail] = val;
    8000192c:	0104b783          	ld	a5,16(s1)
    80001930:	01c4a703          	lw	a4,28(s1)
    80001934:	00e787b3          	add	a5,a5,a4
    80001938:	01278023          	sb	s2,0(a5)
    tail = (tail + 1) % cap;
    8000193c:	01c4a783          	lw	a5,28(s1)
    80001940:	0017879b          	addiw	a5,a5,1
    80001944:	0084a703          	lw	a4,8(s1)
    80001948:	02e7e7bb          	remw	a5,a5,a4
    8000194c:	00f4ae23          	sw	a5,28(s1)
    _sem::ksignal(mutexTail);
    80001950:	0384b503          	ld	a0,56(s1)
    80001954:	00000097          	auipc	ra,0x0
    80001958:	2a8080e7          	jalr	680(ra) # 80001bfc <_ZN4_sem7ksignalEPS_>

    _sem::ksignal(itemAvailable);
    8000195c:	0284b503          	ld	a0,40(s1)
    80001960:	00000097          	auipc	ra,0x0
    80001964:	29c080e7          	jalr	668(ra) # 80001bfc <_ZN4_sem7ksignalEPS_>

}
    80001968:	01813083          	ld	ra,24(sp)
    8000196c:	01013403          	ld	s0,16(sp)
    80001970:	00813483          	ld	s1,8(sp)
    80001974:	00013903          	ld	s2,0(sp)
    80001978:	02010113          	addi	sp,sp,32
    8000197c:	00008067          	ret

0000000080001980 <_ZN13ConsoleBuffer3getEv>:

int ConsoleBuffer::get() {
    80001980:	fe010113          	addi	sp,sp,-32
    80001984:	00113c23          	sd	ra,24(sp)
    80001988:	00813823          	sd	s0,16(sp)
    8000198c:	00913423          	sd	s1,8(sp)
    80001990:	01213023          	sd	s2,0(sp)
    80001994:	02010413          	addi	s0,sp,32
    80001998:	00050493          	mv	s1,a0
    _sem::kwait(itemAvailable);
    8000199c:	02853503          	ld	a0,40(a0)
    800019a0:	00000097          	auipc	ra,0x0
    800019a4:	1a8080e7          	jalr	424(ra) # 80001b48 <_ZN4_sem5kwaitEPS_>

    _sem::kwait(mutexHead);
    800019a8:	0304b503          	ld	a0,48(s1)
    800019ac:	00000097          	auipc	ra,0x0
    800019b0:	19c080e7          	jalr	412(ra) # 80001b48 <_ZN4_sem5kwaitEPS_>

    int ret = buffer[head];
    800019b4:	0104b703          	ld	a4,16(s1)
    800019b8:	0184a783          	lw	a5,24(s1)
    800019bc:	00f70733          	add	a4,a4,a5
    800019c0:	00074903          	lbu	s2,0(a4)
    head = (head + 1) % cap;
    800019c4:	0017879b          	addiw	a5,a5,1
    800019c8:	0084a703          	lw	a4,8(s1)
    800019cc:	02e7e7bb          	remw	a5,a5,a4
    800019d0:	00f4ac23          	sw	a5,24(s1)
    _sem::ksignal(mutexHead);
    800019d4:	0304b503          	ld	a0,48(s1)
    800019d8:	00000097          	auipc	ra,0x0
    800019dc:	224080e7          	jalr	548(ra) # 80001bfc <_ZN4_sem7ksignalEPS_>

    _sem::ksignal(spaceAvailable);
    800019e0:	0204b503          	ld	a0,32(s1)
    800019e4:	00000097          	auipc	ra,0x0
    800019e8:	218080e7          	jalr	536(ra) # 80001bfc <_ZN4_sem7ksignalEPS_>

    return ret;
}
    800019ec:	00090513          	mv	a0,s2
    800019f0:	01813083          	ld	ra,24(sp)
    800019f4:	01013403          	ld	s0,16(sp)
    800019f8:	00813483          	ld	s1,8(sp)
    800019fc:	00013903          	ld	s2,0(sp)
    80001a00:	02010113          	addi	sp,sp,32
    80001a04:	00008067          	ret

0000000080001a08 <_ZN13ConsoleBufferC1Ei>:
ConsoleBuffer::ConsoleBuffer(int _cap) : cap(_cap + 1), head(0), tail(0) {
    80001a08:	fe010113          	addi	sp,sp,-32
    80001a0c:	00113c23          	sd	ra,24(sp)
    80001a10:	00813823          	sd	s0,16(sp)
    80001a14:	00913423          	sd	s1,8(sp)
    80001a18:	01213023          	sd	s2,0(sp)
    80001a1c:	02010413          	addi	s0,sp,32
    80001a20:	00050493          	mv	s1,a0
    80001a24:	00058913          	mv	s2,a1
    80001a28:	00006797          	auipc	a5,0x6
    80001a2c:	8c078793          	addi	a5,a5,-1856 # 800072e8 <_ZTV13ConsoleBuffer+0x10>
    80001a30:	00f53023          	sd	a5,0(a0)
    80001a34:	0015871b          	addiw	a4,a1,1
    80001a38:	0007079b          	sext.w	a5,a4
    80001a3c:	00e52423          	sw	a4,8(a0)
    80001a40:	00052c23          	sw	zero,24(a0)
    80001a44:	00052e23          	sw	zero,28(a0)
    size_t sz = (sizeof(char)*cap + sizeof(size_t))/MEM_BLOCK_SIZE + (((sizeof(char)*cap + sizeof(size_t))%MEM_BLOCK_SIZE)==0?0:1);
    80001a48:	00878793          	addi	a5,a5,8
    80001a4c:	0067d513          	srli	a0,a5,0x6
    80001a50:	03f7f793          	andi	a5,a5,63
    80001a54:	00f037b3          	snez	a5,a5
    buffer = (char *)MemoryAllocator::kmem_alloc(sz);
    80001a58:	00f50533          	add	a0,a0,a5
    80001a5c:	00001097          	auipc	ra,0x1
    80001a60:	6f8080e7          	jalr	1784(ra) # 80003154 <_ZN15MemoryAllocator10kmem_allocEm>
    80001a64:	00a4b823          	sd	a0,16(s1)
    _sem::ksem_open(&itemAvailable,0);
    80001a68:	00000593          	li	a1,0
    80001a6c:	02848513          	addi	a0,s1,40
    80001a70:	00000097          	auipc	ra,0x0
    80001a74:	220080e7          	jalr	544(ra) # 80001c90 <_ZN4_sem9ksem_openEPPS_j>
    _sem::ksem_open(&spaceAvailable,_cap);
    80001a78:	00090593          	mv	a1,s2
    80001a7c:	02048513          	addi	a0,s1,32
    80001a80:	00000097          	auipc	ra,0x0
    80001a84:	210080e7          	jalr	528(ra) # 80001c90 <_ZN4_sem9ksem_openEPPS_j>
    _sem::ksem_open(&mutexHead, 1);
    80001a88:	00100593          	li	a1,1
    80001a8c:	03048513          	addi	a0,s1,48
    80001a90:	00000097          	auipc	ra,0x0
    80001a94:	200080e7          	jalr	512(ra) # 80001c90 <_ZN4_sem9ksem_openEPPS_j>
    _sem::ksem_open(&mutexTail, 1);
    80001a98:	00100593          	li	a1,1
    80001a9c:	03848513          	addi	a0,s1,56
    80001aa0:	00000097          	auipc	ra,0x0
    80001aa4:	1f0080e7          	jalr	496(ra) # 80001c90 <_ZN4_sem9ksem_openEPPS_j>
}
    80001aa8:	01813083          	ld	ra,24(sp)
    80001aac:	01013403          	ld	s0,16(sp)
    80001ab0:	00813483          	ld	s1,8(sp)
    80001ab4:	00013903          	ld	s2,0(sp)
    80001ab8:	02010113          	addi	sp,sp,32
    80001abc:	00008067          	ret

0000000080001ac0 <_ZN13ConsoleBuffer6getCntEv>:

int ConsoleBuffer::getCnt() {
    80001ac0:	fe010113          	addi	sp,sp,-32
    80001ac4:	00113c23          	sd	ra,24(sp)
    80001ac8:	00813823          	sd	s0,16(sp)
    80001acc:	00913423          	sd	s1,8(sp)
    80001ad0:	01213023          	sd	s2,0(sp)
    80001ad4:	02010413          	addi	s0,sp,32
    80001ad8:	00050493          	mv	s1,a0
    int ret;

    _sem::kwait(mutexHead);
    80001adc:	03053503          	ld	a0,48(a0)
    80001ae0:	00000097          	auipc	ra,0x0
    80001ae4:	068080e7          	jalr	104(ra) # 80001b48 <_ZN4_sem5kwaitEPS_>
    _sem::kwait(mutexTail);
    80001ae8:	0384b503          	ld	a0,56(s1)
    80001aec:	00000097          	auipc	ra,0x0
    80001af0:	05c080e7          	jalr	92(ra) # 80001b48 <_ZN4_sem5kwaitEPS_>


    if (tail >= head) {
    80001af4:	01c4a783          	lw	a5,28(s1)
    80001af8:	0184a903          	lw	s2,24(s1)
    80001afc:	0327ce63          	blt	a5,s2,80001b38 <_ZN13ConsoleBuffer6getCntEv+0x78>
        ret = tail - head;
    80001b00:	4127893b          	subw	s2,a5,s2
    } else {
        ret = cap - head + tail;
    }

    _sem::ksignal(mutexTail);
    80001b04:	0384b503          	ld	a0,56(s1)
    80001b08:	00000097          	auipc	ra,0x0
    80001b0c:	0f4080e7          	jalr	244(ra) # 80001bfc <_ZN4_sem7ksignalEPS_>
    _sem::ksignal(mutexHead);
    80001b10:	0304b503          	ld	a0,48(s1)
    80001b14:	00000097          	auipc	ra,0x0
    80001b18:	0e8080e7          	jalr	232(ra) # 80001bfc <_ZN4_sem7ksignalEPS_>

    return ret;
    80001b1c:	00090513          	mv	a0,s2
    80001b20:	01813083          	ld	ra,24(sp)
    80001b24:	01013403          	ld	s0,16(sp)
    80001b28:	00813483          	ld	s1,8(sp)
    80001b2c:	00013903          	ld	s2,0(sp)
    80001b30:	02010113          	addi	sp,sp,32
    80001b34:	00008067          	ret
        ret = cap - head + tail;
    80001b38:	0084a703          	lw	a4,8(s1)
    80001b3c:	4127093b          	subw	s2,a4,s2
    80001b40:	00f9093b          	addw	s2,s2,a5
    80001b44:	fc1ff06f          	j	80001b04 <_ZN13ConsoleBuffer6getCntEv+0x44>

0000000080001b48 <_ZN4_sem5kwaitEPS_>:
#include "../h/semaphore.hpp"

int _sem::kwait(sem_t id){
    80001b48:	fe010113          	addi	sp,sp,-32
    80001b4c:	00113c23          	sd	ra,24(sp)
    80001b50:	00813823          	sd	s0,16(sp)
    80001b54:	00913423          	sd	s1,8(sp)
    80001b58:	01213023          	sd	s2,0(sp)
    80001b5c:	02010413          	addi	s0,sp,32
    80001b60:	00050493          	mv	s1,a0
    id->value--;
    80001b64:	00052783          	lw	a5,0(a0)
    80001b68:	fff7879b          	addiw	a5,a5,-1
    80001b6c:	00f52023          	sw	a5,0(a0)
    if(id->value<0){
    80001b70:	02079713          	slli	a4,a5,0x20
    80001b74:	02074463          	bltz	a4,80001b9c <_ZN4_sem5kwaitEPS_+0x54>
        id->SemaforQueue.addLast(_thread::running);
        _thread::setTimeSliceCounter();
        _thread::kdispatch(1);
    }
    if(id->sem_exists==0) return -1;
    80001b78:	0184a783          	lw	a5,24(s1)
    80001b7c:	06078c63          	beqz	a5,80001bf4 <_ZN4_sem5kwaitEPS_+0xac>
    else return 0;
    80001b80:	00000513          	li	a0,0
}
    80001b84:	01813083          	ld	ra,24(sp)
    80001b88:	01013403          	ld	s0,16(sp)
    80001b8c:	00813483          	ld	s1,8(sp)
    80001b90:	00013903          	ld	s2,0(sp)
    80001b94:	02010113          	addi	sp,sp,32
    80001b98:	00008067          	ret
        id->SemaforQueue.addLast(_thread::running);
    80001b9c:	00006797          	auipc	a5,0x6
    80001ba0:	8347b783          	ld	a5,-1996(a5) # 800073d0 <_GLOBAL_OFFSET_TABLE_+0x28>
    80001ba4:	0007b903          	ld	s2,0(a5)
        if (!tail) tail = novi;
    }

    void addLast(T data) {
        size_t sz = (sizeof(Elem)+sizeof(size_t))/MEM_BLOCK_SIZE + (((sizeof(Elem)+sizeof(size_t))%MEM_BLOCK_SIZE)==0?0:1);
        Elem* novi = (Elem*) MemoryAllocator::kmem_alloc(sz);
    80001ba8:	00100513          	li	a0,1
    80001bac:	00001097          	auipc	ra,0x1
    80001bb0:	5a8080e7          	jalr	1448(ra) # 80003154 <_ZN15MemoryAllocator10kmem_allocEm>
        novi->data = data; novi->next = nullptr;
    80001bb4:	01253423          	sd	s2,8(a0)
    80001bb8:	00053023          	sd	zero,0(a0)
        if (tail) {
    80001bbc:	0104b783          	ld	a5,16(s1)
    80001bc0:	02078463          	beqz	a5,80001be8 <_ZN4_sem5kwaitEPS_+0xa0>
            tail->next = novi;
    80001bc4:	00a7b023          	sd	a0,0(a5)
            tail = novi;
    80001bc8:	00a4b823          	sd	a0,16(s1)
    static _thread *running;
    static void kdispatch(int flag);
    static void threadWrapper();
    static int sleep(time_t time);
    static void addToScheduler(thread_t);
    static void setTimeSliceCounter(){ timeSliceCounter = 0; }
    80001bcc:	00006797          	auipc	a5,0x6
    80001bd0:	83c7b783          	ld	a5,-1988(a5) # 80007408 <_GLOBAL_OFFSET_TABLE_+0x60>
    80001bd4:	0007b023          	sd	zero,0(a5)
        _thread::kdispatch(1);
    80001bd8:	00100513          	li	a0,1
    80001bdc:	00001097          	auipc	ra,0x1
    80001be0:	418080e7          	jalr	1048(ra) # 80002ff4 <_ZN7_thread9kdispatchEi>
    80001be4:	f95ff06f          	j	80001b78 <_ZN4_sem5kwaitEPS_+0x30>
        }
        else
            head = tail = novi;
    80001be8:	00a4b823          	sd	a0,16(s1)
    80001bec:	00a4b423          	sd	a0,8(s1)
    80001bf0:	fddff06f          	j	80001bcc <_ZN4_sem5kwaitEPS_+0x84>
    if(id->sem_exists==0) return -1;
    80001bf4:	fff00513          	li	a0,-1
    80001bf8:	f8dff06f          	j	80001b84 <_ZN4_sem5kwaitEPS_+0x3c>

0000000080001bfc <_ZN4_sem7ksignalEPS_>:
int _sem::ksignal(sem_t id){
    id->value++;
    80001bfc:	00052703          	lw	a4,0(a0)
    80001c00:	0017071b          	addiw	a4,a4,1
    80001c04:	0007069b          	sext.w	a3,a4
    80001c08:	00e52023          	sw	a4,0(a0)
    if(id->value<=0){
    80001c0c:	00d05663          	blez	a3,80001c18 <_ZN4_sem7ksignalEPS_+0x1c>
        _thread* t = id->SemaforQueue.removeFirst();
        if(t == nullptr) return -1;
        Scheduler::put(t);
    }
    return 0;
    80001c10:	00000513          	li	a0,0
    80001c14:	00008067          	ret
    80001c18:	00050793          	mv	a5,a0
    }

    T removeFirst() {
        //if (!head) return nullptr;
        if(!head) return 0;
    80001c1c:	00853503          	ld	a0,8(a0)
    80001c20:	06050463          	beqz	a0,80001c88 <_ZN4_sem7ksignalEPS_+0x8c>
int _sem::ksignal(sem_t id){
    80001c24:	fe010113          	addi	sp,sp,-32
    80001c28:	00113c23          	sd	ra,24(sp)
    80001c2c:	00813823          	sd	s0,16(sp)
    80001c30:	00913423          	sd	s1,8(sp)
    80001c34:	02010413          	addi	s0,sp,32
        Elem* elem = head;
        head = head->next;
    80001c38:	00053703          	ld	a4,0(a0)
    80001c3c:	00e7b423          	sd	a4,8(a5)
        if (!head) tail = nullptr;
    80001c40:	02070c63          	beqz	a4,80001c78 <_ZN4_sem7ksignalEPS_+0x7c>
        T data = elem->data;
    80001c44:	00853483          	ld	s1,8(a0)
        MemoryAllocator::kmem_free(elem);
    80001c48:	00001097          	auipc	ra,0x1
    80001c4c:	5fc080e7          	jalr	1532(ra) # 80003244 <_ZN15MemoryAllocator9kmem_freeEPv>
        if(t == nullptr) return -1;
    80001c50:	02048863          	beqz	s1,80001c80 <_ZN4_sem7ksignalEPS_+0x84>
        Scheduler::put(t);
    80001c54:	00048513          	mv	a0,s1
    80001c58:	00001097          	auipc	ra,0x1
    80001c5c:	0a8080e7          	jalr	168(ra) # 80002d00 <_ZN9Scheduler3putEP7_thread>
    return 0;
    80001c60:	00000513          	li	a0,0
}
    80001c64:	01813083          	ld	ra,24(sp)
    80001c68:	01013403          	ld	s0,16(sp)
    80001c6c:	00813483          	ld	s1,8(sp)
    80001c70:	02010113          	addi	sp,sp,32
    80001c74:	00008067          	ret
        if (!head) tail = nullptr;
    80001c78:	0007b823          	sd	zero,16(a5)
    80001c7c:	fc9ff06f          	j	80001c44 <_ZN4_sem7ksignalEPS_+0x48>
        if(t == nullptr) return -1;
    80001c80:	fff00513          	li	a0,-1
    80001c84:	fe1ff06f          	j	80001c64 <_ZN4_sem7ksignalEPS_+0x68>
    80001c88:	fff00513          	li	a0,-1
}
    80001c8c:	00008067          	ret

0000000080001c90 <_ZN4_sem9ksem_openEPPS_j>:

int _sem::ksem_open(sem_t *handle, unsigned init) {
    80001c90:	fe010113          	addi	sp,sp,-32
    80001c94:	00113c23          	sd	ra,24(sp)
    80001c98:	00813823          	sd	s0,16(sp)
    80001c9c:	00913423          	sd	s1,8(sp)
    80001ca0:	01213023          	sd	s2,0(sp)
    80001ca4:	02010413          	addi	s0,sp,32
    80001ca8:	00050493          	mv	s1,a0
    80001cac:	00058913          	mv	s2,a1
    size_t sz = (sizeof(_sem)+sizeof(size_t))/MEM_BLOCK_SIZE + (((sizeof(_sem)+sizeof(size_t))%MEM_BLOCK_SIZE)==0?0:1);
    sem_t sem = (sem_t)(MemoryAllocator::kmem_alloc(sz));
    80001cb0:	00100513          	li	a0,1
    80001cb4:	00001097          	auipc	ra,0x1
    80001cb8:	4a0080e7          	jalr	1184(ra) # 80003154 <_ZN15MemoryAllocator10kmem_allocEm>
    if(sem == nullptr) return -1;
    80001cbc:	02050c63          	beqz	a0,80001cf4 <_ZN4_sem9ksem_openEPPS_j+0x64>
    sem->SemaforQueue.head= nullptr;
    80001cc0:	00053423          	sd	zero,8(a0)
    sem->SemaforQueue.tail= nullptr;
    80001cc4:	00053823          	sd	zero,16(a0)
    sem->value = init;
    80001cc8:	01252023          	sw	s2,0(a0)
    sem->sem_exists = 1;
    80001ccc:	00100793          	li	a5,1
    80001cd0:	00f52c23          	sw	a5,24(a0)
    *handle = sem;
    80001cd4:	00a4b023          	sd	a0,0(s1)
    return 0;
    80001cd8:	00000513          	li	a0,0
}
    80001cdc:	01813083          	ld	ra,24(sp)
    80001ce0:	01013403          	ld	s0,16(sp)
    80001ce4:	00813483          	ld	s1,8(sp)
    80001ce8:	00013903          	ld	s2,0(sp)
    80001cec:	02010113          	addi	sp,sp,32
    80001cf0:	00008067          	ret
    if(sem == nullptr) return -1;
    80001cf4:	fff00513          	li	a0,-1
    80001cf8:	fe5ff06f          	j	80001cdc <_ZN4_sem9ksem_openEPPS_j+0x4c>

0000000080001cfc <_ZN4_sem10ksem_closeEPS_>:

int _sem::ksem_close(sem_t handle) {
    80001cfc:	fe010113          	addi	sp,sp,-32
    80001d00:	00113c23          	sd	ra,24(sp)
    80001d04:	00813823          	sd	s0,16(sp)
    80001d08:	00913423          	sd	s1,8(sp)
    80001d0c:	02010413          	addi	s0,sp,32
    80001d10:	00050493          	mv	s1,a0
        MemoryAllocator::kmem_free(elem);
        return data;
    }

    T peekFirst() {
        if (!head) return nullptr;
    80001d14:	00853503          	ld	a0,8(a0)
    80001d18:	02050263          	beqz	a0,80001d3c <_ZN4_sem10ksem_closeEPS_+0x40>
        return head->data;
    80001d1c:	00853503          	ld	a0,8(a0)
    80001d20:	01c0006f          	j	80001d3c <_ZN4_sem10ksem_closeEPS_+0x40>
        if (!head) tail = nullptr;
    80001d24:	0004b823          	sd	zero,16(s1)
        MemoryAllocator::kmem_free(elem);
    80001d28:	00001097          	auipc	ra,0x1
    80001d2c:	51c080e7          	jalr	1308(ra) # 80003244 <_ZN15MemoryAllocator9kmem_freeEPv>
        if (!head) return nullptr;
    80001d30:	0084b783          	ld	a5,8(s1)
    80001d34:	02078663          	beqz	a5,80001d60 <_ZN4_sem10ksem_closeEPS_+0x64>
        return head->data;
    80001d38:	0087b503          	ld	a0,8(a5)
    _thread* t = handle->SemaforQueue.peekFirst();
    while(t != nullptr){
    80001d3c:	02050263          	beqz	a0,80001d60 <_ZN4_sem10ksem_closeEPS_+0x64>
        Scheduler::put(t);
    80001d40:	00001097          	auipc	ra,0x1
    80001d44:	fc0080e7          	jalr	-64(ra) # 80002d00 <_ZN9Scheduler3putEP7_thread>
        if(!head) return 0;
    80001d48:	0084b503          	ld	a0,8(s1)
    80001d4c:	fe0502e3          	beqz	a0,80001d30 <_ZN4_sem10ksem_closeEPS_+0x34>
        head = head->next;
    80001d50:	00053783          	ld	a5,0(a0)
    80001d54:	00f4b423          	sd	a5,8(s1)
        if (!head) tail = nullptr;
    80001d58:	fc0798e3          	bnez	a5,80001d28 <_ZN4_sem10ksem_closeEPS_+0x2c>
    80001d5c:	fc9ff06f          	j	80001d24 <_ZN4_sem10ksem_closeEPS_+0x28>
        handle->SemaforQueue.removeFirst();
        t = handle->SemaforQueue.peekFirst();
    }
    handle->sem_exists=0;
    80001d60:	0004ac23          	sw	zero,24(s1)
    return 0;
    80001d64:	00000513          	li	a0,0
    80001d68:	01813083          	ld	ra,24(sp)
    80001d6c:	01013403          	ld	s0,16(sp)
    80001d70:	00813483          	ld	s1,8(sp)
    80001d74:	02010113          	addi	sp,sp,32
    80001d78:	00008067          	ret

0000000080001d7c <_Z11printStringPKc>:

#define LOCK() while(copy_and_swap(lockPrint, 0, 1))
#define UNLOCK() while(copy_and_swap(lockPrint, 1, 0))

void printString(char const *string)
{
    80001d7c:	fe010113          	addi	sp,sp,-32
    80001d80:	00113c23          	sd	ra,24(sp)
    80001d84:	00813823          	sd	s0,16(sp)
    80001d88:	00913423          	sd	s1,8(sp)
    80001d8c:	02010413          	addi	s0,sp,32
    80001d90:	00050493          	mv	s1,a0
    LOCK();
    80001d94:	00100613          	li	a2,1
    80001d98:	00000593          	li	a1,0
    80001d9c:	00005517          	auipc	a0,0x5
    80001da0:	6cc50513          	addi	a0,a0,1740 # 80007468 <lockPrint>
    80001da4:	fffff097          	auipc	ra,0xfffff
    80001da8:	25c080e7          	jalr	604(ra) # 80001000 <copy_and_swap>
    80001dac:	fe0514e3          	bnez	a0,80001d94 <_Z11printStringPKc+0x18>
    while (*string != '\0')
    80001db0:	0004c503          	lbu	a0,0(s1)
    80001db4:	00050a63          	beqz	a0,80001dc8 <_Z11printStringPKc+0x4c>
    {
        putc(*string);
    80001db8:	00000097          	auipc	ra,0x0
    80001dbc:	98c080e7          	jalr	-1652(ra) # 80001744 <_Z4putcc>
        string++;
    80001dc0:	00148493          	addi	s1,s1,1
    while (*string != '\0')
    80001dc4:	fedff06f          	j	80001db0 <_Z11printStringPKc+0x34>
    }
    UNLOCK();
    80001dc8:	00000613          	li	a2,0
    80001dcc:	00100593          	li	a1,1
    80001dd0:	00005517          	auipc	a0,0x5
    80001dd4:	69850513          	addi	a0,a0,1688 # 80007468 <lockPrint>
    80001dd8:	fffff097          	auipc	ra,0xfffff
    80001ddc:	228080e7          	jalr	552(ra) # 80001000 <copy_and_swap>
    80001de0:	fe0514e3          	bnez	a0,80001dc8 <_Z11printStringPKc+0x4c>
}
    80001de4:	01813083          	ld	ra,24(sp)
    80001de8:	01013403          	ld	s0,16(sp)
    80001dec:	00813483          	ld	s1,8(sp)
    80001df0:	02010113          	addi	sp,sp,32
    80001df4:	00008067          	ret

0000000080001df8 <_Z9getStringPci>:

char* getString(char *buf, int max) {
    80001df8:	fd010113          	addi	sp,sp,-48
    80001dfc:	02113423          	sd	ra,40(sp)
    80001e00:	02813023          	sd	s0,32(sp)
    80001e04:	00913c23          	sd	s1,24(sp)
    80001e08:	01213823          	sd	s2,16(sp)
    80001e0c:	01313423          	sd	s3,8(sp)
    80001e10:	01413023          	sd	s4,0(sp)
    80001e14:	03010413          	addi	s0,sp,48
    80001e18:	00050993          	mv	s3,a0
    80001e1c:	00058a13          	mv	s4,a1
    LOCK();
    80001e20:	00100613          	li	a2,1
    80001e24:	00000593          	li	a1,0
    80001e28:	00005517          	auipc	a0,0x5
    80001e2c:	64050513          	addi	a0,a0,1600 # 80007468 <lockPrint>
    80001e30:	fffff097          	auipc	ra,0xfffff
    80001e34:	1d0080e7          	jalr	464(ra) # 80001000 <copy_and_swap>
    80001e38:	fe0514e3          	bnez	a0,80001e20 <_Z9getStringPci+0x28>
    int i, cc;
    char c;

    for(i=0; i+1 < max; ){
    80001e3c:	00000913          	li	s2,0
    80001e40:	00090493          	mv	s1,s2
    80001e44:	0019091b          	addiw	s2,s2,1
    80001e48:	03495a63          	bge	s2,s4,80001e7c <_Z9getStringPci+0x84>
        cc = getc();
    80001e4c:	00000097          	auipc	ra,0x0
    80001e50:	8b4080e7          	jalr	-1868(ra) # 80001700 <_Z4getcv>
        if(cc < 1)
    80001e54:	02050463          	beqz	a0,80001e7c <_Z9getStringPci+0x84>
            break;
        c = cc;
        buf[i++] = c;
    80001e58:	009984b3          	add	s1,s3,s1
    80001e5c:	00a48023          	sb	a0,0(s1)
        if(c == '\n' || c == '\r')
    80001e60:	00a00793          	li	a5,10
    80001e64:	00f50a63          	beq	a0,a5,80001e78 <_Z9getStringPci+0x80>
    80001e68:	00d00793          	li	a5,13
    80001e6c:	fcf51ae3          	bne	a0,a5,80001e40 <_Z9getStringPci+0x48>
        buf[i++] = c;
    80001e70:	00090493          	mv	s1,s2
    80001e74:	0080006f          	j	80001e7c <_Z9getStringPci+0x84>
    80001e78:	00090493          	mv	s1,s2
            break;
    }
    buf[i] = '\0';
    80001e7c:	009984b3          	add	s1,s3,s1
    80001e80:	00048023          	sb	zero,0(s1)

    UNLOCK();
    80001e84:	00000613          	li	a2,0
    80001e88:	00100593          	li	a1,1
    80001e8c:	00005517          	auipc	a0,0x5
    80001e90:	5dc50513          	addi	a0,a0,1500 # 80007468 <lockPrint>
    80001e94:	fffff097          	auipc	ra,0xfffff
    80001e98:	16c080e7          	jalr	364(ra) # 80001000 <copy_and_swap>
    80001e9c:	fe0514e3          	bnez	a0,80001e84 <_Z9getStringPci+0x8c>
    return buf;
}
    80001ea0:	00098513          	mv	a0,s3
    80001ea4:	02813083          	ld	ra,40(sp)
    80001ea8:	02013403          	ld	s0,32(sp)
    80001eac:	01813483          	ld	s1,24(sp)
    80001eb0:	01013903          	ld	s2,16(sp)
    80001eb4:	00813983          	ld	s3,8(sp)
    80001eb8:	00013a03          	ld	s4,0(sp)
    80001ebc:	03010113          	addi	sp,sp,48
    80001ec0:	00008067          	ret

0000000080001ec4 <_Z11stringToIntPKc>:

int stringToInt(const char *s) {
    80001ec4:	ff010113          	addi	sp,sp,-16
    80001ec8:	00813423          	sd	s0,8(sp)
    80001ecc:	01010413          	addi	s0,sp,16
    80001ed0:	00050693          	mv	a3,a0
    int n;

    n = 0;
    80001ed4:	00000513          	li	a0,0
    while ('0' <= *s && *s <= '9')
    80001ed8:	0006c603          	lbu	a2,0(a3)
    80001edc:	fd06071b          	addiw	a4,a2,-48
    80001ee0:	0ff77713          	andi	a4,a4,255
    80001ee4:	00900793          	li	a5,9
    80001ee8:	02e7e063          	bltu	a5,a4,80001f08 <_Z11stringToIntPKc+0x44>
        n = n * 10 + *s++ - '0';
    80001eec:	0025179b          	slliw	a5,a0,0x2
    80001ef0:	00a787bb          	addw	a5,a5,a0
    80001ef4:	0017979b          	slliw	a5,a5,0x1
    80001ef8:	00168693          	addi	a3,a3,1
    80001efc:	00c787bb          	addw	a5,a5,a2
    80001f00:	fd07851b          	addiw	a0,a5,-48
    while ('0' <= *s && *s <= '9')
    80001f04:	fd5ff06f          	j	80001ed8 <_Z11stringToIntPKc+0x14>
    return n;
}
    80001f08:	00813403          	ld	s0,8(sp)
    80001f0c:	01010113          	addi	sp,sp,16
    80001f10:	00008067          	ret

0000000080001f14 <_Z8printIntiii>:

char digits[] = "0123456789ABCDEF";

void printInt(int xx, int base, int sgn)
{
    80001f14:	fc010113          	addi	sp,sp,-64
    80001f18:	02113c23          	sd	ra,56(sp)
    80001f1c:	02813823          	sd	s0,48(sp)
    80001f20:	02913423          	sd	s1,40(sp)
    80001f24:	03213023          	sd	s2,32(sp)
    80001f28:	01313c23          	sd	s3,24(sp)
    80001f2c:	04010413          	addi	s0,sp,64
    80001f30:	00050493          	mv	s1,a0
    80001f34:	00058913          	mv	s2,a1
    80001f38:	00060993          	mv	s3,a2
    LOCK();
    80001f3c:	00100613          	li	a2,1
    80001f40:	00000593          	li	a1,0
    80001f44:	00005517          	auipc	a0,0x5
    80001f48:	52450513          	addi	a0,a0,1316 # 80007468 <lockPrint>
    80001f4c:	fffff097          	auipc	ra,0xfffff
    80001f50:	0b4080e7          	jalr	180(ra) # 80001000 <copy_and_swap>
    80001f54:	fe0514e3          	bnez	a0,80001f3c <_Z8printIntiii+0x28>
    char buf[16];
    int i, neg;
    uint x;

    neg = 0;
    if(sgn && xx < 0){
    80001f58:	00098463          	beqz	s3,80001f60 <_Z8printIntiii+0x4c>
    80001f5c:	0804c463          	bltz	s1,80001fe4 <_Z8printIntiii+0xd0>
        neg = 1;
        x = -xx;
    } else {
        x = xx;
    80001f60:	0004851b          	sext.w	a0,s1
    neg = 0;
    80001f64:	00000593          	li	a1,0
    }

    i = 0;
    80001f68:	00000493          	li	s1,0
    do{
        buf[i++] = digits[x % base];
    80001f6c:	0009079b          	sext.w	a5,s2
    80001f70:	0325773b          	remuw	a4,a0,s2
    80001f74:	00048613          	mv	a2,s1
    80001f78:	0014849b          	addiw	s1,s1,1
    80001f7c:	02071693          	slli	a3,a4,0x20
    80001f80:	0206d693          	srli	a3,a3,0x20
    80001f84:	00005717          	auipc	a4,0x5
    80001f88:	38470713          	addi	a4,a4,900 # 80007308 <digits>
    80001f8c:	00d70733          	add	a4,a4,a3
    80001f90:	00074683          	lbu	a3,0(a4)
    80001f94:	fd040713          	addi	a4,s0,-48
    80001f98:	00c70733          	add	a4,a4,a2
    80001f9c:	fed70823          	sb	a3,-16(a4)
    }while((x /= base) != 0);
    80001fa0:	0005071b          	sext.w	a4,a0
    80001fa4:	0325553b          	divuw	a0,a0,s2
    80001fa8:	fcf772e3          	bgeu	a4,a5,80001f6c <_Z8printIntiii+0x58>
    if(neg)
    80001fac:	00058c63          	beqz	a1,80001fc4 <_Z8printIntiii+0xb0>
        buf[i++] = '-';
    80001fb0:	fd040793          	addi	a5,s0,-48
    80001fb4:	009784b3          	add	s1,a5,s1
    80001fb8:	02d00793          	li	a5,45
    80001fbc:	fef48823          	sb	a5,-16(s1)
    80001fc0:	0026049b          	addiw	s1,a2,2

    while(--i >= 0)
    80001fc4:	fff4849b          	addiw	s1,s1,-1
    80001fc8:	0204c463          	bltz	s1,80001ff0 <_Z8printIntiii+0xdc>
        putc(buf[i]);
    80001fcc:	fd040793          	addi	a5,s0,-48
    80001fd0:	009787b3          	add	a5,a5,s1
    80001fd4:	ff07c503          	lbu	a0,-16(a5)
    80001fd8:	fffff097          	auipc	ra,0xfffff
    80001fdc:	76c080e7          	jalr	1900(ra) # 80001744 <_Z4putcc>
    80001fe0:	fe5ff06f          	j	80001fc4 <_Z8printIntiii+0xb0>
        x = -xx;
    80001fe4:	4090053b          	negw	a0,s1
        neg = 1;
    80001fe8:	00100593          	li	a1,1
        x = -xx;
    80001fec:	f7dff06f          	j	80001f68 <_Z8printIntiii+0x54>

    UNLOCK();
    80001ff0:	00000613          	li	a2,0
    80001ff4:	00100593          	li	a1,1
    80001ff8:	00005517          	auipc	a0,0x5
    80001ffc:	47050513          	addi	a0,a0,1136 # 80007468 <lockPrint>
    80002000:	fffff097          	auipc	ra,0xfffff
    80002004:	000080e7          	jalr	ra # 80001000 <copy_and_swap>
    80002008:	fe0514e3          	bnez	a0,80001ff0 <_Z8printIntiii+0xdc>
    8000200c:	03813083          	ld	ra,56(sp)
    80002010:	03013403          	ld	s0,48(sp)
    80002014:	02813483          	ld	s1,40(sp)
    80002018:	02013903          	ld	s2,32(sp)
    8000201c:	01813983          	ld	s3,24(sp)
    80002020:	04010113          	addi	sp,sp,64
    80002024:	00008067          	ret

0000000080002028 <_ZN5Riscv10popSppSpieEv>:
#include "../h/sleepQueue.hpp"
#include "../h/inputBuffer.hpp"
#include "../h/outputBuffer.hpp"
#include "../lib/hw.h"

void Riscv::popSppSpie(){
    80002028:	ff010113          	addi	sp,sp,-16
    8000202c:	00813423          	sd	s0,8(sp)
    80002030:	01010413          	addi	s0,sp,16
    __asm__ volatile("csrw sepc, ra");
    80002034:	14109073          	csrw	sepc,ra
    __asm__ volatile("sret");
    80002038:	10200073          	sret
}
    8000203c:	00813403          	ld	s0,8(sp)
    80002040:	01010113          	addi	sp,sp,16
    80002044:	00008067          	ret

0000000080002048 <_ZN5Riscv11consoleFuncEPv>:

void Riscv::consoleFunc(void *arg) {
    80002048:	ff010113          	addi	sp,sp,-16
    8000204c:	00113423          	sd	ra,8(sp)
    80002050:	00813023          	sd	s0,0(sp)
    80002054:	01010413          	addi	s0,sp,16
    80002058:	01c0006f          	j	80002074 <_ZN5Riscv11consoleFuncEPv+0x2c>
inline void Riscv::w_sstatus(uint64 sstatus) {
    __asm__ volatile("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
}

inline void Riscv::ms_sstatus(uint64 mask) {
    __asm__ volatile("csrs sstatus, %[mask]" : : [mask] "r"(mask));
    8000205c:	00200793          	li	a5,2
    80002060:	1007a073          	csrs	sstatus,a5
            int val = OutputBuffer::outputBuffer->get();
            if(val == 0) break;
            *((char*)CONSOLE_TX_DATA) = val;
        }
        Riscv::ms_sstatus(Riscv::SSTATUS_SSIE);
        userMode();
    80002064:	fffff097          	auipc	ra,0xfffff
    80002068:	720080e7          	jalr	1824(ra) # 80001784 <_Z8userModev>
        thread_dispatch();
    8000206c:	fffff097          	auipc	ra,0xfffff
    80002070:	454080e7          	jalr	1108(ra) # 800014c0 <_Z15thread_dispatchv>
        kernelMode();
    80002074:	fffff097          	auipc	ra,0xfffff
    80002078:	74c080e7          	jalr	1868(ra) # 800017c0 <_Z10kernelModev>
}

inline void Riscv::mc_sstatus(uint64 mask) {
    __asm__ volatile("csrc sstatus, %[mask]" : : [mask] "r"(mask));
    8000207c:	00200793          	li	a5,2
    80002080:	1007b073          	csrc	sstatus,a5
        while((*((char*)CONSOLE_STATUS)&CONSOLE_TX_STATUS_BIT)){
    80002084:	00005797          	auipc	a5,0x5
    80002088:	3347b783          	ld	a5,820(a5) # 800073b8 <_GLOBAL_OFFSET_TABLE_+0x10>
    8000208c:	0007b783          	ld	a5,0(a5)
    80002090:	0007c783          	lbu	a5,0(a5)
    80002094:	0207f793          	andi	a5,a5,32
    80002098:	fc0782e3          	beqz	a5,8000205c <_ZN5Riscv11consoleFuncEPv+0x14>
            int val = OutputBuffer::outputBuffer->get();
    8000209c:	00005797          	auipc	a5,0x5
    800020a0:	3647b783          	ld	a5,868(a5) # 80007400 <_GLOBAL_OFFSET_TABLE_+0x58>
    800020a4:	0007b503          	ld	a0,0(a5)
    800020a8:	00053783          	ld	a5,0(a0)
    800020ac:	0187b783          	ld	a5,24(a5)
    800020b0:	000780e7          	jalr	a5
            if(val == 0) break;
    800020b4:	fa0504e3          	beqz	a0,8000205c <_ZN5Riscv11consoleFuncEPv+0x14>
            *((char*)CONSOLE_TX_DATA) = val;
    800020b8:	00005797          	auipc	a5,0x5
    800020bc:	3287b783          	ld	a5,808(a5) # 800073e0 <_GLOBAL_OFFSET_TABLE_+0x38>
    800020c0:	0007b783          	ld	a5,0(a5)
    800020c4:	00a78023          	sb	a0,0(a5)
        while((*((char*)CONSOLE_STATUS)&CONSOLE_TX_STATUS_BIT)){
    800020c8:	fbdff06f          	j	80002084 <_ZN5Riscv11consoleFuncEPv+0x3c>

00000000800020cc <_ZN5Riscv20handleSupervisorTrapEv>:
    }
}


void Riscv::handleSupervisorTrap() {
    800020cc:	f5010113          	addi	sp,sp,-176
    800020d0:	0a113423          	sd	ra,168(sp)
    800020d4:	0a813023          	sd	s0,160(sp)
    800020d8:	08913c23          	sd	s1,152(sp)
    800020dc:	09213823          	sd	s2,144(sp)
    800020e0:	0b010413          	addi	s0,sp,176
    void* volatile arg0 = nullptr, *volatile arg1 = nullptr, *volatile arg2 = nullptr, *volatile arg3 = nullptr,
    800020e4:	fc043c23          	sd	zero,-40(s0)
    800020e8:	fc043823          	sd	zero,-48(s0)
    800020ec:	fc043423          	sd	zero,-56(s0)
    800020f0:	fc043023          	sd	zero,-64(s0)
            *volatile arg4 = nullptr, *volatile arg5 = nullptr, *volatile arg6 = nullptr;
    800020f4:	fa043c23          	sd	zero,-72(s0)
    800020f8:	fa043823          	sd	zero,-80(s0)
    800020fc:	fa043423          	sd	zero,-88(s0)
    uint64 volatile a0 = 0;
    80002100:	fa043023          	sd	zero,-96(s0)
    __asm__ volatile ("mv %[a0], a0" : [a0] "=r"(a0));
    80002104:	00050793          	mv	a5,a0
    80002108:	faf43023          	sd	a5,-96(s0)
    __asm__ volatile ("mv %[arg6], a7" : [arg6] "=r"(arg6));
    8000210c:	00088793          	mv	a5,a7
    80002110:	faf43423          	sd	a5,-88(s0)
    __asm__ volatile ("mv %[arg5], a6" : [arg5] "=r"(arg5));
    80002114:	00080793          	mv	a5,a6
    80002118:	faf43823          	sd	a5,-80(s0)
    __asm__ volatile ("mv %[arg4], a5" : [arg4] "=r"(arg4));
    8000211c:	00078793          	mv	a5,a5
    80002120:	faf43c23          	sd	a5,-72(s0)
    __asm__ volatile ("mv %[arg3], a4" : [arg3] "=r"(arg3));
    80002124:	00070793          	mv	a5,a4
    80002128:	fcf43023          	sd	a5,-64(s0)
    __asm__ volatile ("mv %[arg2], a3" : [arg2] "=r"(arg2));
    8000212c:	00068793          	mv	a5,a3
    80002130:	fcf43423          	sd	a5,-56(s0)
    __asm__ volatile ("mv %[arg1], a2" : [arg1] "=r"(arg1));
    80002134:	00060793          	mv	a5,a2
    80002138:	fcf43823          	sd	a5,-48(s0)
    __asm__ volatile ("mv %[arg0], a1" : [arg0] "=r"(arg0));
    8000213c:	00058793          	mv	a5,a1
    80002140:	fcf43c23          	sd	a5,-40(s0)
    __asm__ volatile("csrr %[scause], scause" : [scause] "=r"(scause));
    80002144:	142027f3          	csrr	a5,scause
    80002148:	f6f43c23          	sd	a5,-136(s0)
    return scause;
    8000214c:	f7843703          	ld	a4,-136(s0)

    uint64 scause = Riscv::r_scause();
    if (scause == 0x0000000000000009UL || scause == 0x0000000000000008UL)
    80002150:	ff870693          	addi	a3,a4,-8
    80002154:	00100793          	li	a5,1
    80002158:	08d7f063          	bgeu	a5,a3,800021d8 <_ZN5Riscv20handleSupervisorTrapEv+0x10c>

        if(a0!= 0x50 && a0 != 0x51){
            Riscv::w_sstatus(sstatus);
        }
        Riscv::w_sepc(sepc);
    } else if (scause == 0x8000000000000001UL) {
    8000215c:	fff00793          	li	a5,-1
    80002160:	03f79793          	slli	a5,a5,0x3f
    80002164:	00178793          	addi	a5,a5,1
    80002168:	26f70a63          	beq	a4,a5,800023dc <_ZN5Riscv20handleSupervisorTrapEv+0x310>
            _thread::timeSliceCounter = 0;
            _thread::kdispatch(0);
            w_sstatus(sstatus);
            w_sepc(sepc);
        }
    } else if (scause == 0x8000000000000009UL) {
    8000216c:	fff00793          	li	a5,-1
    80002170:	03f79793          	slli	a5,a5,0x3f
    80002174:	00978793          	addi	a5,a5,9
    80002178:	0ef71663          	bne	a4,a5,80002264 <_ZN5Riscv20handleSupervisorTrapEv+0x198>
        int id = plic_claim();
    8000217c:	00002097          	auipc	ra,0x2
    80002180:	a58080e7          	jalr	-1448(ra) # 80003bd4 <plic_claim>
    80002184:	00050913          	mv	s2,a0
        int max_loaded = 100;
    80002188:	06400493          	li	s1,100
        while((*((char*)CONSOLE_STATUS)&CONSOLE_RX_STATUS_BIT) && max_loaded>0){
    8000218c:	00005797          	auipc	a5,0x5
    80002190:	22c7b783          	ld	a5,556(a5) # 800073b8 <_GLOBAL_OFFSET_TABLE_+0x10>
    80002194:	0007b783          	ld	a5,0(a5)
    80002198:	0007c783          	lbu	a5,0(a5)
    8000219c:	0017f793          	andi	a5,a5,1
    800021a0:	2c078063          	beqz	a5,80002460 <_ZN5Riscv20handleSupervisorTrapEv+0x394>
    800021a4:	2a905e63          	blez	s1,80002460 <_ZN5Riscv20handleSupervisorTrapEv+0x394>
            char val = *((char*)CONSOLE_RX_DATA);
    800021a8:	00005797          	auipc	a5,0x5
    800021ac:	2087b783          	ld	a5,520(a5) # 800073b0 <_GLOBAL_OFFSET_TABLE_+0x8>
    800021b0:	0007b703          	ld	a4,0(a5)
            InputBuffer::inputBuffer->put(val);
    800021b4:	00005797          	auipc	a5,0x5
    800021b8:	20c7b783          	ld	a5,524(a5) # 800073c0 <_GLOBAL_OFFSET_TABLE_+0x18>
    800021bc:	0007b503          	ld	a0,0(a5)
    800021c0:	00053783          	ld	a5,0(a0)
    800021c4:	0107b783          	ld	a5,16(a5)
    800021c8:	00074583          	lbu	a1,0(a4)
    800021cc:	000780e7          	jalr	a5
            max_loaded--;
    800021d0:	fff4849b          	addiw	s1,s1,-1
        while((*((char*)CONSOLE_STATUS)&CONSOLE_RX_STATUS_BIT) && max_loaded>0){
    800021d4:	fb9ff06f          	j	8000218c <_ZN5Riscv20handleSupervisorTrapEv+0xc0>
    __asm__ volatile("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    800021d8:	141027f3          	csrr	a5,sepc
    800021dc:	f8f43423          	sd	a5,-120(s0)
    return sepc;
    800021e0:	f8843783          	ld	a5,-120(s0)
        long volatile sepc = Riscv::r_sepc() + 4;
    800021e4:	00478793          	addi	a5,a5,4
    800021e8:	f4f43c23          	sd	a5,-168(s0)
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    800021ec:	100027f3          	csrr	a5,sstatus
    800021f0:	f8f43023          	sd	a5,-128(s0)
    return sstatus;
    800021f4:	f8043783          	ld	a5,-128(s0)
        long volatile sstatus = Riscv::r_sstatus();
    800021f8:	f6f43023          	sd	a5,-160(s0)
        __asm__ volatile("csrr %0, sscratch": "=r"(resVal));
    800021fc:	140024f3          	csrr	s1,sscratch
        switch(a0) {
    80002200:	fa043783          	ld	a5,-96(s0)
    80002204:	05100713          	li	a4,81
    80002208:	02f76863          	bltu	a4,a5,80002238 <_ZN5Riscv20handleSupervisorTrapEv+0x16c>
    8000220c:	00279793          	slli	a5,a5,0x2
    80002210:	00004717          	auipc	a4,0x4
    80002214:	e1070713          	addi	a4,a4,-496 # 80006020 <CONSOLE_STATUS+0x10>
    80002218:	00e787b3          	add	a5,a5,a4
    8000221c:	0007a783          	lw	a5,0(a5)
    80002220:	00e787b3          	add	a5,a5,a4
    80002224:	00078067          	jr	a5
                MemoryAllocator::kmem_alloc(*(uint64*)arg0);
    80002228:	fd843783          	ld	a5,-40(s0)
    8000222c:	0007b503          	ld	a0,0(a5)
    80002230:	00001097          	auipc	ra,0x1
    80002234:	f24080e7          	jalr	-220(ra) # 80003154 <_ZN15MemoryAllocator10kmem_allocEm>
        __asm__ volatile("sd a0, 80(%0)": : "r" (resVal));
    80002238:	04a4b823          	sd	a0,80(s1)
        if(a0!= 0x50 && a0 != 0x51){
    8000223c:	fa043703          	ld	a4,-96(s0)
    80002240:	05000793          	li	a5,80
    80002244:	00f70c63          	beq	a4,a5,8000225c <_ZN5Riscv20handleSupervisorTrapEv+0x190>
    80002248:	fa043703          	ld	a4,-96(s0)
    8000224c:	05100793          	li	a5,81
    80002250:	00f70663          	beq	a4,a5,8000225c <_ZN5Riscv20handleSupervisorTrapEv+0x190>
            Riscv::w_sstatus(sstatus);
    80002254:	f6043783          	ld	a5,-160(s0)
    __asm__ volatile("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    80002258:	10079073          	csrw	sstatus,a5
        Riscv::w_sepc(sepc);
    8000225c:	f5843783          	ld	a5,-168(s0)
    __asm__ volatile("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    80002260:	14179073          	csrw	sepc,a5

    } else {
        // unexpected trap cause
    }

}
    80002264:	0a813083          	ld	ra,168(sp)
    80002268:	0a013403          	ld	s0,160(sp)
    8000226c:	09813483          	ld	s1,152(sp)
    80002270:	09013903          	ld	s2,144(sp)
    80002274:	0b010113          	addi	sp,sp,176
    80002278:	00008067          	ret
                MemoryAllocator::kmem_free(arg0);
    8000227c:	fd843503          	ld	a0,-40(s0)
    80002280:	00001097          	auipc	ra,0x1
    80002284:	fc4080e7          	jalr	-60(ra) # 80003244 <_ZN15MemoryAllocator9kmem_freeEPv>
                break;
    80002288:	fb1ff06f          	j	80002238 <_ZN5Riscv20handleSupervisorTrapEv+0x16c>
                _thread::createThread((thread_t*)arg0, (void (*)(void*))arg1, arg2, (uint64*)arg3,1);
    8000228c:	fd843503          	ld	a0,-40(s0)
    80002290:	fd043583          	ld	a1,-48(s0)
    80002294:	fc843603          	ld	a2,-56(s0)
    80002298:	fc043683          	ld	a3,-64(s0)
    8000229c:	00100713          	li	a4,1
    800022a0:	00001097          	auipc	ra,0x1
    800022a4:	c80080e7          	jalr	-896(ra) # 80002f20 <_ZN7_thread12createThreadEPPS_PFvPvES2_Pmi>
                break;
    800022a8:	f91ff06f          	j	80002238 <_ZN5Riscv20handleSupervisorTrapEv+0x16c>
                _thread::running->setFinished(true);
    800022ac:	00005797          	auipc	a5,0x5
    800022b0:	1247b783          	ld	a5,292(a5) # 800073d0 <_GLOBAL_OFFSET_TABLE_+0x28>
    800022b4:	0007b783          	ld	a5,0(a5)
    ~_thread() {
        if(stack)
            MemoryAllocator::kmem_free(stack);
    }
    bool isFinished() const { return finished; }
    void setFinished(bool value) { finished = value; }
    800022b8:	00100713          	li	a4,1
    800022bc:	02e78823          	sb	a4,48(a5)
    static _thread *running;
    static void kdispatch(int flag);
    static void threadWrapper();
    static int sleep(time_t time);
    static void addToScheduler(thread_t);
    static void setTimeSliceCounter(){ timeSliceCounter = 0; }
    800022c0:	00005797          	auipc	a5,0x5
    800022c4:	1487b783          	ld	a5,328(a5) # 80007408 <_GLOBAL_OFFSET_TABLE_+0x60>
    800022c8:	0007b023          	sd	zero,0(a5)
                _thread::kdispatch(0);
    800022cc:	00000513          	li	a0,0
    800022d0:	00001097          	auipc	ra,0x1
    800022d4:	d24080e7          	jalr	-732(ra) # 80002ff4 <_ZN7_thread9kdispatchEi>
                break;
    800022d8:	f61ff06f          	j	80002238 <_ZN5Riscv20handleSupervisorTrapEv+0x16c>
    800022dc:	00005797          	auipc	a5,0x5
    800022e0:	12c7b783          	ld	a5,300(a5) # 80007408 <_GLOBAL_OFFSET_TABLE_+0x60>
    800022e4:	0007b023          	sd	zero,0(a5)
                _thread::kdispatch(0);
    800022e8:	00000513          	li	a0,0
    800022ec:	00001097          	auipc	ra,0x1
    800022f0:	d08080e7          	jalr	-760(ra) # 80002ff4 <_ZN7_thread9kdispatchEi>
                break;
    800022f4:	f45ff06f          	j	80002238 <_ZN5Riscv20handleSupervisorTrapEv+0x16c>
                _thread::createThread((thread_t*)arg0, (void (*)(void*))arg1, arg2, (uint64*)arg3,0);
    800022f8:	fd843503          	ld	a0,-40(s0)
    800022fc:	fd043583          	ld	a1,-48(s0)
    80002300:	fc843603          	ld	a2,-56(s0)
    80002304:	fc043683          	ld	a3,-64(s0)
    80002308:	00000713          	li	a4,0
    8000230c:	00001097          	auipc	ra,0x1
    80002310:	c14080e7          	jalr	-1004(ra) # 80002f20 <_ZN7_thread12createThreadEPPS_PFvPvES2_Pmi>
                break;
    80002314:	f25ff06f          	j	80002238 <_ZN5Riscv20handleSupervisorTrapEv+0x16c>
                _thread::addToScheduler((thread_t)arg0);
    80002318:	fd843503          	ld	a0,-40(s0)
    8000231c:	00001097          	auipc	ra,0x1
    80002320:	da8080e7          	jalr	-600(ra) # 800030c4 <_ZN7_thread14addToSchedulerEPS_>
                break;
    80002324:	f15ff06f          	j	80002238 <_ZN5Riscv20handleSupervisorTrapEv+0x16c>
                _sem::ksem_open((sem_t*)arg0, *(uint64*)arg1);
    80002328:	fd843503          	ld	a0,-40(s0)
    8000232c:	fd043783          	ld	a5,-48(s0)
    80002330:	0007a583          	lw	a1,0(a5)
    80002334:	00000097          	auipc	ra,0x0
    80002338:	95c080e7          	jalr	-1700(ra) # 80001c90 <_ZN4_sem9ksem_openEPPS_j>
                break;
    8000233c:	efdff06f          	j	80002238 <_ZN5Riscv20handleSupervisorTrapEv+0x16c>
                _sem::ksem_close((sem_t)arg0);
    80002340:	fd843503          	ld	a0,-40(s0)
    80002344:	00000097          	auipc	ra,0x0
    80002348:	9b8080e7          	jalr	-1608(ra) # 80001cfc <_ZN4_sem10ksem_closeEPS_>
                break;
    8000234c:	eedff06f          	j	80002238 <_ZN5Riscv20handleSupervisorTrapEv+0x16c>
                _sem::kwait((sem_t)arg0);
    80002350:	fd843503          	ld	a0,-40(s0)
    80002354:	fffff097          	auipc	ra,0xfffff
    80002358:	7f4080e7          	jalr	2036(ra) # 80001b48 <_ZN4_sem5kwaitEPS_>
                break;
    8000235c:	eddff06f          	j	80002238 <_ZN5Riscv20handleSupervisorTrapEv+0x16c>
                _sem::ksignal((sem_t)arg0);
    80002360:	fd843503          	ld	a0,-40(s0)
    80002364:	00000097          	auipc	ra,0x0
    80002368:	898080e7          	jalr	-1896(ra) # 80001bfc <_ZN4_sem7ksignalEPS_>
                break;
    8000236c:	ecdff06f          	j	80002238 <_ZN5Riscv20handleSupervisorTrapEv+0x16c>
                _thread::sleep(*(time_t*)arg0);
    80002370:	fd843783          	ld	a5,-40(s0)
    80002374:	0007b503          	ld	a0,0(a5)
    80002378:	00001097          	auipc	ra,0x1
    8000237c:	ce8080e7          	jalr	-792(ra) # 80003060 <_ZN7_thread5sleepEm>
                break;
    80002380:	eb9ff06f          	j	80002238 <_ZN5Riscv20handleSupervisorTrapEv+0x16c>
                InputBuffer::inputBuffer->get();
    80002384:	00005797          	auipc	a5,0x5
    80002388:	03c7b783          	ld	a5,60(a5) # 800073c0 <_GLOBAL_OFFSET_TABLE_+0x18>
    8000238c:	0007b503          	ld	a0,0(a5)
    80002390:	00053783          	ld	a5,0(a0)
    80002394:	0187b783          	ld	a5,24(a5)
    80002398:	000780e7          	jalr	a5
                break;
    8000239c:	e9dff06f          	j	80002238 <_ZN5Riscv20handleSupervisorTrapEv+0x16c>
                OutputBuffer::outputBuffer->put(*(char*)arg0);
    800023a0:	00005797          	auipc	a5,0x5
    800023a4:	0607b783          	ld	a5,96(a5) # 80007400 <_GLOBAL_OFFSET_TABLE_+0x58>
    800023a8:	0007b503          	ld	a0,0(a5)
    800023ac:	00053783          	ld	a5,0(a0)
    800023b0:	0107b783          	ld	a5,16(a5)
    800023b4:	fd843703          	ld	a4,-40(s0)
    800023b8:	00074583          	lbu	a1,0(a4)
    800023bc:	000780e7          	jalr	a5
                break;
    800023c0:	e79ff06f          	j	80002238 <_ZN5Riscv20handleSupervisorTrapEv+0x16c>
    __asm__ volatile("csrc sstatus, %[mask]" : : [mask] "r"(mask));
    800023c4:	10000793          	li	a5,256
    800023c8:	1007b073          	csrc	sstatus,a5
}
    800023cc:	e6dff06f          	j	80002238 <_ZN5Riscv20handleSupervisorTrapEv+0x16c>
    __asm__ volatile("csrs sstatus, %[mask]" : : [mask] "r"(mask));
    800023d0:	10000793          	li	a5,256
    800023d4:	1007a073          	csrs	sstatus,a5
}
    800023d8:	e61ff06f          	j	80002238 <_ZN5Riscv20handleSupervisorTrapEv+0x16c>
inline void Riscv::ms_sip(uint64 mask) {
    __asm__ volatile("csrs sip, %[mask]" : : [mask] "r"(mask));
}

inline void Riscv::mc_sip(uint64 mask) {
    __asm__ volatile("csrc sip, %[mask]" : : [mask] "r"(mask));
    800023dc:	00200793          	li	a5,2
    800023e0:	1447b073          	csrc	sip,a5
        sleepQueue::iterate();
    800023e4:	00001097          	auipc	ra,0x1
    800023e8:	a28080e7          	jalr	-1496(ra) # 80002e0c <_ZN10sleepQueue7iterateEv>
        _thread::timeSliceCounter++;
    800023ec:	00005717          	auipc	a4,0x5
    800023f0:	01c73703          	ld	a4,28(a4) # 80007408 <_GLOBAL_OFFSET_TABLE_+0x60>
    800023f4:	00073783          	ld	a5,0(a4)
    800023f8:	00178793          	addi	a5,a5,1
    800023fc:	00f73023          	sd	a5,0(a4)
        if (_thread::timeSliceCounter >= _thread::running->getTimeSlice()) {
    80002400:	00005717          	auipc	a4,0x5
    80002404:	fd073703          	ld	a4,-48(a4) # 800073d0 <_GLOBAL_OFFSET_TABLE_+0x28>
    80002408:	00073703          	ld	a4,0(a4)
    uint64 getTimeSlice() const { return timeSlice; }
    8000240c:	02873703          	ld	a4,40(a4)
    80002410:	e4e7eae3          	bltu	a5,a4,80002264 <_ZN5Riscv20handleSupervisorTrapEv+0x198>
    __asm__ volatile("csrr %[sepc], sepc" : [sepc] "=r"(sepc));
    80002414:	141027f3          	csrr	a5,sepc
    80002418:	f8f43c23          	sd	a5,-104(s0)
    return sepc;
    8000241c:	f9843783          	ld	a5,-104(s0)
            uint64 volatile sepc = r_sepc();
    80002420:	f6f43423          	sd	a5,-152(s0)
    __asm__ volatile ("csrr %[sstatus], sstatus" : [sstatus] "=r"(sstatus));
    80002424:	100027f3          	csrr	a5,sstatus
    80002428:	f8f43823          	sd	a5,-112(s0)
    return sstatus;
    8000242c:	f9043783          	ld	a5,-112(s0)
            uint64 volatile sstatus = r_sstatus();
    80002430:	f6f43823          	sd	a5,-144(s0)
            _thread::timeSliceCounter = 0;
    80002434:	00005797          	auipc	a5,0x5
    80002438:	fd47b783          	ld	a5,-44(a5) # 80007408 <_GLOBAL_OFFSET_TABLE_+0x60>
    8000243c:	0007b023          	sd	zero,0(a5)
            _thread::kdispatch(0);
    80002440:	00000513          	li	a0,0
    80002444:	00001097          	auipc	ra,0x1
    80002448:	bb0080e7          	jalr	-1104(ra) # 80002ff4 <_ZN7_thread9kdispatchEi>
            w_sstatus(sstatus);
    8000244c:	f7043783          	ld	a5,-144(s0)
    __asm__ volatile("csrw sstatus, %[sstatus]" : : [sstatus] "r"(sstatus));
    80002450:	10079073          	csrw	sstatus,a5
            w_sepc(sepc);
    80002454:	f6843783          	ld	a5,-152(s0)
    __asm__ volatile("csrw sepc, %[sepc]" : : [sepc] "r"(sepc));
    80002458:	14179073          	csrw	sepc,a5
}
    8000245c:	e09ff06f          	j	80002264 <_ZN5Riscv20handleSupervisorTrapEv+0x198>
        plic_complete(id);
    80002460:	00090513          	mv	a0,s2
    80002464:	00001097          	auipc	ra,0x1
    80002468:	7a8080e7          	jalr	1960(ra) # 80003c0c <plic_complete>
}
    8000246c:	df9ff06f          	j	80002264 <_ZN5Riscv20handleSupervisorTrapEv+0x198>

0000000080002470 <_ZN5Riscv7sysCallEmPvS0_S0_S0_>:

void Riscv::sysCall(uint64 code, void* arg1, void* arg2, void* arg3, void* arg4) {
    80002470:	ff010113          	addi	sp,sp,-16
    80002474:	00813423          	sd	s0,8(sp)
    80002478:	01010413          	addi	s0,sp,16
    __asm__ volatile("ecall");
    8000247c:	00000073          	ecall
}
    80002480:	00813403          	ld	s0,8(sp)
    80002484:	01010113          	addi	sp,sp,16
    80002488:	00008067          	ret

000000008000248c <_Z12idleFunctionPv>:

//#include "../h/ThreadSleep_C_API_test.hpp" // thread_sleep test C API
//#include "../h/ConsumerProducer_CPP_API_test.hpp" // zadatak 4. CPP API i asinhrona promena konteksta


void idleFunction(void* arg){
    8000248c:	ff010113          	addi	sp,sp,-16
    80002490:	00113423          	sd	ra,8(sp)
    80002494:	00813023          	sd	s0,0(sp)
    80002498:	01010413          	addi	s0,sp,16
    while(true){
        thread_dispatch();
    8000249c:	fffff097          	auipc	ra,0xfffff
    800024a0:	024080e7          	jalr	36(ra) # 800014c0 <_Z15thread_dispatchv>
    while(true){
    800024a4:	ff9ff06f          	j	8000249c <_Z12idleFunctionPv+0x10>

00000000800024a8 <_Z10kernelInitv>:

thread_t idle;
thread_t consoleThread;
thread_t mainThread;

void kernelInit(){
    800024a8:	fe010113          	addi	sp,sp,-32
    800024ac:	00113c23          	sd	ra,24(sp)
    800024b0:	00813823          	sd	s0,16(sp)
    800024b4:	00913423          	sd	s1,8(sp)
    800024b8:	02010413          	addi	s0,sp,32
    MemoryAllocator::kinitMemory();
    800024bc:	00001097          	auipc	ra,0x1
    800024c0:	c30080e7          	jalr	-976(ra) # 800030ec <_ZN15MemoryAllocator11kinitMemoryEv>
    Riscv::w_stvec((uint64) &Riscv::supervisorTrap);
    800024c4:	00005797          	auipc	a5,0x5
    800024c8:	f147b783          	ld	a5,-236(a5) # 800073d8 <_GLOBAL_OFFSET_TABLE_+0x30>
    __asm__ volatile("csrw stvec, %[stvec]" : : [stvec] "r"(stvec));
    800024cc:	10579073          	csrw	stvec,a5

    InputBuffer::createInputBuffer();
    800024d0:	fffff097          	auipc	ra,0xfffff
    800024d4:	c90080e7          	jalr	-880(ra) # 80001160 <_ZN11InputBuffer17createInputBufferEv>
    OutputBuffer::createOutputBuffer();
    800024d8:	00000097          	auipc	ra,0x0
    800024dc:	51c080e7          	jalr	1308(ra) # 800029f4 <_ZN12OutputBuffer18createOutputBufferEv>

    thread_create(&mainThread, nullptr, nullptr);
    800024e0:	00005497          	auipc	s1,0x5
    800024e4:	f9048493          	addi	s1,s1,-112 # 80007470 <mainThread>
    800024e8:	00000613          	li	a2,0
    800024ec:	00000593          	li	a1,0
    800024f0:	00048513          	mv	a0,s1
    800024f4:	fffff097          	auipc	ra,0xfffff
    800024f8:	f14080e7          	jalr	-236(ra) # 80001408 <_Z13thread_createPP7_threadPFvPvES2_>
    _thread::running = mainThread;
    800024fc:	0004b703          	ld	a4,0(s1)
    80002500:	00005797          	auipc	a5,0x5
    80002504:	ed07b783          	ld	a5,-304(a5) # 800073d0 <_GLOBAL_OFFSET_TABLE_+0x28>
    80002508:	00e7b023          	sd	a4,0(a5)

    thread_create(&idle, idleFunction, nullptr);
    8000250c:	00000613          	li	a2,0
    80002510:	00000597          	auipc	a1,0x0
    80002514:	f7c58593          	addi	a1,a1,-132 # 8000248c <_Z12idleFunctionPv>
    80002518:	00005517          	auipc	a0,0x5
    8000251c:	f6050513          	addi	a0,a0,-160 # 80007478 <idle>
    80002520:	fffff097          	auipc	ra,0xfffff
    80002524:	ee8080e7          	jalr	-280(ra) # 80001408 <_Z13thread_createPP7_threadPFvPvES2_>

    thread_create(&consoleThread, Riscv::consoleFunc, nullptr); //fja,globalna ili u riscv, uzimanje iz output bufera dok ima nesto i stavljam u registar
    80002528:	00000613          	li	a2,0
    8000252c:	00005597          	auipc	a1,0x5
    80002530:	ecc5b583          	ld	a1,-308(a1) # 800073f8 <_GLOBAL_OFFSET_TABLE_+0x50>
    80002534:	00005517          	auipc	a0,0x5
    80002538:	f4c50513          	addi	a0,a0,-180 # 80007480 <consoleThread>
    8000253c:	fffff097          	auipc	ra,0xfffff
    80002540:	ecc080e7          	jalr	-308(ra) # 80001408 <_Z13thread_createPP7_threadPFvPvES2_>
    __asm__ volatile("csrs sstatus, %[mask]" : : [mask] "r"(mask));
    80002544:	00200793          	li	a5,2
    80002548:	1007a073          	csrs	sstatus,a5

    Riscv::ms_sstatus(Riscv::SSTATUS_SSIE);

}
    8000254c:	01813083          	ld	ra,24(sp)
    80002550:	01013403          	ld	s0,16(sp)
    80002554:	00813483          	ld	s1,8(sp)
    80002558:	02010113          	addi	sp,sp,32
    8000255c:	00008067          	ret

0000000080002560 <_Z9dealocatev>:

void dealocate(){
    80002560:	fe010113          	addi	sp,sp,-32
    80002564:	00113c23          	sd	ra,24(sp)
    80002568:	00813823          	sd	s0,16(sp)
    8000256c:	00913423          	sd	s1,8(sp)
    80002570:	02010413          	addi	s0,sp,32
    InputBuffer::deleteInputBuffer();
    80002574:	fffff097          	auipc	ra,0xfffff
    80002578:	c6c080e7          	jalr	-916(ra) # 800011e0 <_ZN11InputBuffer17deleteInputBufferEv>
    OutputBuffer::deleteOutputBuffer();
    8000257c:	00000097          	auipc	ra,0x0
    80002580:	4f8080e7          	jalr	1272(ra) # 80002a74 <_ZN12OutputBuffer18deleteOutputBufferEv>
    delete idle;
    80002584:	00005497          	auipc	s1,0x5
    80002588:	ef44b483          	ld	s1,-268(s1) # 80007478 <idle>
    8000258c:	02048063          	beqz	s1,800025ac <_Z9dealocatev+0x4c>
        if(stack)
    80002590:	0204b503          	ld	a0,32(s1)
    80002594:	00050663          	beqz	a0,800025a0 <_Z9dealocatev+0x40>
            MemoryAllocator::kmem_free(stack);
    80002598:	00001097          	auipc	ra,0x1
    8000259c:	cac080e7          	jalr	-852(ra) # 80003244 <_ZN15MemoryAllocator9kmem_freeEPv>

    void operator delete(void * arg){
        MemoryAllocator::kmem_free(arg);
    800025a0:	00048513          	mv	a0,s1
    800025a4:	00001097          	auipc	ra,0x1
    800025a8:	ca0080e7          	jalr	-864(ra) # 80003244 <_ZN15MemoryAllocator9kmem_freeEPv>
    delete consoleThread;
    800025ac:	00005497          	auipc	s1,0x5
    800025b0:	ed44b483          	ld	s1,-300(s1) # 80007480 <consoleThread>
    800025b4:	02048063          	beqz	s1,800025d4 <_Z9dealocatev+0x74>
        if(stack)
    800025b8:	0204b503          	ld	a0,32(s1)
    800025bc:	00050663          	beqz	a0,800025c8 <_Z9dealocatev+0x68>
            MemoryAllocator::kmem_free(stack);
    800025c0:	00001097          	auipc	ra,0x1
    800025c4:	c84080e7          	jalr	-892(ra) # 80003244 <_ZN15MemoryAllocator9kmem_freeEPv>
        MemoryAllocator::kmem_free(arg);
    800025c8:	00048513          	mv	a0,s1
    800025cc:	00001097          	auipc	ra,0x1
    800025d0:	c78080e7          	jalr	-904(ra) # 80003244 <_ZN15MemoryAllocator9kmem_freeEPv>
    delete mainThread;
    800025d4:	00005497          	auipc	s1,0x5
    800025d8:	e9c4b483          	ld	s1,-356(s1) # 80007470 <mainThread>
    800025dc:	02048063          	beqz	s1,800025fc <_Z9dealocatev+0x9c>
        if(stack)
    800025e0:	0204b503          	ld	a0,32(s1)
    800025e4:	00050663          	beqz	a0,800025f0 <_Z9dealocatev+0x90>
            MemoryAllocator::kmem_free(stack);
    800025e8:	00001097          	auipc	ra,0x1
    800025ec:	c5c080e7          	jalr	-932(ra) # 80003244 <_ZN15MemoryAllocator9kmem_freeEPv>
        MemoryAllocator::kmem_free(arg);
    800025f0:	00048513          	mv	a0,s1
    800025f4:	00001097          	auipc	ra,0x1
    800025f8:	c50080e7          	jalr	-944(ra) # 80003244 <_ZN15MemoryAllocator9kmem_freeEPv>
}
    800025fc:	01813083          	ld	ra,24(sp)
    80002600:	01013403          	ld	s0,16(sp)
    80002604:	00813483          	ld	s1,8(sp)
    80002608:	02010113          	addi	sp,sp,32
    8000260c:	00008067          	ret

0000000080002610 <_Z8userMainv>:

void userMain() {
    80002610:	ff010113          	addi	sp,sp,-16
    80002614:	00813423          	sd	s0,8(sp)
    80002618:	01010413          	addi	s0,sp,16
    //producerConsumer_CPP_Sync_API(); // zadatak 3., kompletan CPP API sa semaforima, sinhrona promena konteksta

    //testSleeping(); // thread_sleep test C API
    //ConsumerProducerCPP::testConsumerProducer(); // zadatak 4. CPP API i asinhrona promena konteksta, kompletan test svega

}
    8000261c:	00813403          	ld	s0,8(sp)
    80002620:	01010113          	addi	sp,sp,16
    80002624:	00008067          	ret

0000000080002628 <main>:

void main() {
    80002628:	ff010113          	addi	sp,sp,-16
    8000262c:	00113423          	sd	ra,8(sp)
    80002630:	00813023          	sd	s0,0(sp)
    80002634:	01010413          	addi	s0,sp,16
    kernelInit();
    80002638:	00000097          	auipc	ra,0x0
    8000263c:	e70080e7          	jalr	-400(ra) # 800024a8 <_Z10kernelInitv>
    userMode();
    80002640:	fffff097          	auipc	ra,0xfffff
    80002644:	144080e7          	jalr	324(ra) # 80001784 <_Z8userModev>
    userMain();
    kernelMode();
    80002648:	fffff097          	auipc	ra,0xfffff
    8000264c:	178080e7          	jalr	376(ra) # 800017c0 <_Z10kernelModev>
    dealocate();
    80002650:	00000097          	auipc	ra,0x0
    80002654:	f10080e7          	jalr	-240(ra) # 80002560 <_Z9dealocatev>
    80002658:	00813083          	ld	ra,8(sp)
    8000265c:	00013403          	ld	s0,0(sp)
    80002660:	01010113          	addi	sp,sp,16
    80002664:	00008067          	ret

0000000080002668 <_Znwm>:
#include "../h/syscall_cpp.hpp"

void *operator new(size_t n) { return mem_alloc(n); }
    80002668:	ff010113          	addi	sp,sp,-16
    8000266c:	00113423          	sd	ra,8(sp)
    80002670:	00813023          	sd	s0,0(sp)
    80002674:	01010413          	addi	s0,sp,16
    80002678:	fffff097          	auipc	ra,0xfffff
    8000267c:	cb4080e7          	jalr	-844(ra) # 8000132c <_Z9mem_allocm>
    80002680:	00813083          	ld	ra,8(sp)
    80002684:	00013403          	ld	s0,0(sp)
    80002688:	01010113          	addi	sp,sp,16
    8000268c:	00008067          	ret

0000000080002690 <_Znam>:
void *operator new[](size_t n) { return mem_alloc(n); }
    80002690:	ff010113          	addi	sp,sp,-16
    80002694:	00113423          	sd	ra,8(sp)
    80002698:	00813023          	sd	s0,0(sp)
    8000269c:	01010413          	addi	s0,sp,16
    800026a0:	fffff097          	auipc	ra,0xfffff
    800026a4:	c8c080e7          	jalr	-884(ra) # 8000132c <_Z9mem_allocm>
    800026a8:	00813083          	ld	ra,8(sp)
    800026ac:	00013403          	ld	s0,0(sp)
    800026b0:	01010113          	addi	sp,sp,16
    800026b4:	00008067          	ret

00000000800026b8 <_ZdlPv>:
void operator delete(void *p) { mem_free(p); }
    800026b8:	ff010113          	addi	sp,sp,-16
    800026bc:	00113423          	sd	ra,8(sp)
    800026c0:	00813023          	sd	s0,0(sp)
    800026c4:	01010413          	addi	s0,sp,16
    800026c8:	fffff097          	auipc	ra,0xfffff
    800026cc:	cf0080e7          	jalr	-784(ra) # 800013b8 <_Z8mem_freePv>
    800026d0:	00813083          	ld	ra,8(sp)
    800026d4:	00013403          	ld	s0,0(sp)
    800026d8:	01010113          	addi	sp,sp,16
    800026dc:	00008067          	ret

00000000800026e0 <_ZdaPv>:
void operator delete[](void *p) { mem_free(p); }
    800026e0:	ff010113          	addi	sp,sp,-16
    800026e4:	00113423          	sd	ra,8(sp)
    800026e8:	00813023          	sd	s0,0(sp)
    800026ec:	01010413          	addi	s0,sp,16
    800026f0:	fffff097          	auipc	ra,0xfffff
    800026f4:	cc8080e7          	jalr	-824(ra) # 800013b8 <_Z8mem_freePv>
    800026f8:	00813083          	ld	ra,8(sp)
    800026fc:	00013403          	ld	s0,0(sp)
    80002700:	01010113          	addi	sp,sp,16
    80002704:	00008067          	ret

0000000080002708 <_ZN6Thread8dispatchEv>:


void Thread::dispatch() {
    80002708:	ff010113          	addi	sp,sp,-16
    8000270c:	00113423          	sd	ra,8(sp)
    80002710:	00813023          	sd	s0,0(sp)
    80002714:	01010413          	addi	s0,sp,16
    thread_dispatch();
    80002718:	fffff097          	auipc	ra,0xfffff
    8000271c:	da8080e7          	jalr	-600(ra) # 800014c0 <_Z15thread_dispatchv>
}
    80002720:	00813083          	ld	ra,8(sp)
    80002724:	00013403          	ld	s0,0(sp)
    80002728:	01010113          	addi	sp,sp,16
    8000272c:	00008067          	ret

0000000080002730 <_ZN6Thread5startEv>:

void Thread::start() {
    80002730:	ff010113          	addi	sp,sp,-16
    80002734:	00113423          	sd	ra,8(sp)
    80002738:	00813023          	sd	s0,0(sp)
    8000273c:	01010413          	addi	s0,sp,16
    addScheduler(myHandle);
    80002740:	00853503          	ld	a0,8(a0)
    80002744:	fffff097          	auipc	ra,0xfffff
    80002748:	e24080e7          	jalr	-476(ra) # 80001568 <_Z12addSchedulerP7_thread>
}
    8000274c:	00813083          	ld	ra,8(sp)
    80002750:	00013403          	ld	s0,0(sp)
    80002754:	01010113          	addi	sp,sp,16
    80002758:	00008067          	ret

000000008000275c <_ZN6Thread5sleepEm>:

void Thread::sleep(time_t t) {
    8000275c:	ff010113          	addi	sp,sp,-16
    80002760:	00113423          	sd	ra,8(sp)
    80002764:	00813023          	sd	s0,0(sp)
    80002768:	01010413          	addi	s0,sp,16
    time_sleep(t);
    8000276c:	fffff097          	auipc	ra,0xfffff
    80002770:	f4c080e7          	jalr	-180(ra) # 800016b8 <_Z10time_sleepm>
}
    80002774:	00813083          	ld	ra,8(sp)
    80002778:	00013403          	ld	s0,0(sp)
    8000277c:	01010113          	addi	sp,sp,16
    80002780:	00008067          	ret

0000000080002784 <_ZN14PeriodicThread7wrapperEPv>:

PeriodicThread::PeriodicThread(time_t period) : Thread(wrapper, new Elem(period, this)){
    flag = true;
}

void PeriodicThread::wrapper(void *arg) {
    80002784:	fe010113          	addi	sp,sp,-32
    80002788:	00113c23          	sd	ra,24(sp)
    8000278c:	00813823          	sd	s0,16(sp)
    80002790:	00913423          	sd	s1,8(sp)
    80002794:	01213023          	sd	s2,0(sp)
    80002798:	02010413          	addi	s0,sp,32
    Elem* elem = (Elem*) arg;
    time_t time = elem->time;
    8000279c:	00053903          	ld	s2,0(a0)
    PeriodicThread* thr = elem->thread;
    800027a0:	00853483          	ld	s1,8(a0)
    while(thr->flag){
    800027a4:	0104c783          	lbu	a5,16(s1)
    800027a8:	02078263          	beqz	a5,800027cc <_ZN14PeriodicThread7wrapperEPv+0x48>
        thr->periodicActivation();
    800027ac:	0004b783          	ld	a5,0(s1)
    800027b0:	0187b783          	ld	a5,24(a5)
    800027b4:	00048513          	mv	a0,s1
    800027b8:	000780e7          	jalr	a5
        sleep(time);
    800027bc:	00090513          	mv	a0,s2
    800027c0:	00000097          	auipc	ra,0x0
    800027c4:	f9c080e7          	jalr	-100(ra) # 8000275c <_ZN6Thread5sleepEm>
    while(thr->flag){
    800027c8:	fddff06f          	j	800027a4 <_ZN14PeriodicThread7wrapperEPv+0x20>
    }
}
    800027cc:	01813083          	ld	ra,24(sp)
    800027d0:	01013403          	ld	s0,16(sp)
    800027d4:	00813483          	ld	s1,8(sp)
    800027d8:	00013903          	ld	s2,0(sp)
    800027dc:	02010113          	addi	sp,sp,32
    800027e0:	00008067          	ret

00000000800027e4 <_ZN6Thread10runWrapperEPv>:
    if(arg!=nullptr){
    800027e4:	02050863          	beqz	a0,80002814 <_ZN6Thread10runWrapperEPv+0x30>
void Thread::runWrapper(void *arg) {
    800027e8:	ff010113          	addi	sp,sp,-16
    800027ec:	00113423          	sd	ra,8(sp)
    800027f0:	00813023          	sd	s0,0(sp)
    800027f4:	01010413          	addi	s0,sp,16
        t->run();
    800027f8:	00053783          	ld	a5,0(a0)
    800027fc:	0107b783          	ld	a5,16(a5)
    80002800:	000780e7          	jalr	a5
}
    80002804:	00813083          	ld	ra,8(sp)
    80002808:	00013403          	ld	s0,0(sp)
    8000280c:	01010113          	addi	sp,sp,16
    80002810:	00008067          	ret
    80002814:	00008067          	ret

0000000080002818 <_ZN9Semaphore4waitEv>:
void Semaphore::wait() {
    80002818:	ff010113          	addi	sp,sp,-16
    8000281c:	00113423          	sd	ra,8(sp)
    80002820:	00813023          	sd	s0,0(sp)
    80002824:	01010413          	addi	s0,sp,16
    sem_wait(myHandle);
    80002828:	00853503          	ld	a0,8(a0)
    8000282c:	fffff097          	auipc	ra,0xfffff
    80002830:	e04080e7          	jalr	-508(ra) # 80001630 <_Z8sem_waitP4_sem>
}
    80002834:	00813083          	ld	ra,8(sp)
    80002838:	00013403          	ld	s0,0(sp)
    8000283c:	01010113          	addi	sp,sp,16
    80002840:	00008067          	ret

0000000080002844 <_ZN9Semaphore6signalEv>:
void Semaphore::signal() {
    80002844:	ff010113          	addi	sp,sp,-16
    80002848:	00113423          	sd	ra,8(sp)
    8000284c:	00813023          	sd	s0,0(sp)
    80002850:	01010413          	addi	s0,sp,16
    sem_signal(myHandle);
    80002854:	00853503          	ld	a0,8(a0)
    80002858:	fffff097          	auipc	ra,0xfffff
    8000285c:	e1c080e7          	jalr	-484(ra) # 80001674 <_Z10sem_signalP4_sem>
}
    80002860:	00813083          	ld	ra,8(sp)
    80002864:	00013403          	ld	s0,0(sp)
    80002868:	01010113          	addi	sp,sp,16
    8000286c:	00008067          	ret

0000000080002870 <_ZN14PeriodicThreadC1Em>:
PeriodicThread::PeriodicThread(time_t period) : Thread(wrapper, new Elem(period, this)){
    80002870:	fe010113          	addi	sp,sp,-32
    80002874:	00113c23          	sd	ra,24(sp)
    80002878:	00813823          	sd	s0,16(sp)
    8000287c:	00913423          	sd	s1,8(sp)
    80002880:	01213023          	sd	s2,0(sp)
    80002884:	02010413          	addi	s0,sp,32
    80002888:	00050493          	mv	s1,a0
    8000288c:	00058913          	mv	s2,a1
    80002890:	01000513          	li	a0,16
    80002894:	00000097          	auipc	ra,0x0
    80002898:	dd4080e7          	jalr	-556(ra) # 80002668 <_Znwm>
    8000289c:	00050613          	mv	a2,a0

private:
    struct Elem{
        time_t time;
        PeriodicThread* thread;
        Elem(time_t t, PeriodicThread*thr) : time(t), thread(thr) {}
    800028a0:	01253023          	sd	s2,0(a0)
    800028a4:	00953423          	sd	s1,8(a0)
    Thread(void (*body)(void*), void* arg){
    800028a8:	00005797          	auipc	a5,0x5
    800028ac:	a8878793          	addi	a5,a5,-1400 # 80007330 <_ZTV6Thread+0x10>
    800028b0:	00f4b023          	sd	a5,0(s1)
        thread_create_cpp(&myHandle, body, arg);
    800028b4:	00000597          	auipc	a1,0x0
    800028b8:	ed058593          	addi	a1,a1,-304 # 80002784 <_ZN14PeriodicThread7wrapperEPv>
    800028bc:	00848513          	addi	a0,s1,8
    800028c0:	fffff097          	auipc	ra,0xfffff
    800028c4:	c3c080e7          	jalr	-964(ra) # 800014fc <_Z17thread_create_cppPP7_threadPFvPvES2_>
    800028c8:	00005797          	auipc	a5,0x5
    800028cc:	a9078793          	addi	a5,a5,-1392 # 80007358 <_ZTV14PeriodicThread+0x10>
    800028d0:	00f4b023          	sd	a5,0(s1)
    flag = true;
    800028d4:	00100793          	li	a5,1
    800028d8:	00f48823          	sb	a5,16(s1)
}
    800028dc:	01813083          	ld	ra,24(sp)
    800028e0:	01013403          	ld	s0,16(sp)
    800028e4:	00813483          	ld	s1,8(sp)
    800028e8:	00013903          	ld	s2,0(sp)
    800028ec:	02010113          	addi	sp,sp,32
    800028f0:	00008067          	ret

00000000800028f4 <_ZN7Console4getcEv>:


char Console::getc() {
    800028f4:	ff010113          	addi	sp,sp,-16
    800028f8:	00113423          	sd	ra,8(sp)
    800028fc:	00813023          	sd	s0,0(sp)
    80002900:	01010413          	addi	s0,sp,16
    return ::getc();
    80002904:	fffff097          	auipc	ra,0xfffff
    80002908:	dfc080e7          	jalr	-516(ra) # 80001700 <_Z4getcv>
}
    8000290c:	00813083          	ld	ra,8(sp)
    80002910:	00013403          	ld	s0,0(sp)
    80002914:	01010113          	addi	sp,sp,16
    80002918:	00008067          	ret

000000008000291c <_ZN7Console4putcEc>:
void Console::putc(char c) {
    8000291c:	ff010113          	addi	sp,sp,-16
    80002920:	00113423          	sd	ra,8(sp)
    80002924:	00813023          	sd	s0,0(sp)
    80002928:	01010413          	addi	s0,sp,16
     ::putc(c);
    8000292c:	fffff097          	auipc	ra,0xfffff
    80002930:	e18080e7          	jalr	-488(ra) # 80001744 <_Z4putcc>

    80002934:	00813083          	ld	ra,8(sp)
    80002938:	00013403          	ld	s0,0(sp)
    8000293c:	01010113          	addi	sp,sp,16
    80002940:	00008067          	ret

0000000080002944 <_ZN6ThreadD1Ev>:
    virtual ~Thread(){}
    80002944:	ff010113          	addi	sp,sp,-16
    80002948:	00813423          	sd	s0,8(sp)
    8000294c:	01010413          	addi	s0,sp,16
    80002950:	00813403          	ld	s0,8(sp)
    80002954:	01010113          	addi	sp,sp,16
    80002958:	00008067          	ret

000000008000295c <_ZN6Thread3runEv>:
    virtual void run(){}
    8000295c:	ff010113          	addi	sp,sp,-16
    80002960:	00813423          	sd	s0,8(sp)
    80002964:	01010413          	addi	s0,sp,16
    80002968:	00813403          	ld	s0,8(sp)
    8000296c:	01010113          	addi	sp,sp,16
    80002970:	00008067          	ret

0000000080002974 <_ZN14PeriodicThread18periodicActivationEv>:
    virtual void periodicActivation(){}
    80002974:	ff010113          	addi	sp,sp,-16
    80002978:	00813423          	sd	s0,8(sp)
    8000297c:	01010413          	addi	s0,sp,16
    80002980:	00813403          	ld	s0,8(sp)
    80002984:	01010113          	addi	sp,sp,16
    80002988:	00008067          	ret

000000008000298c <_ZN14PeriodicThreadD1Ev>:
class PeriodicThread : public Thread{
    8000298c:	ff010113          	addi	sp,sp,-16
    80002990:	00813423          	sd	s0,8(sp)
    80002994:	01010413          	addi	s0,sp,16
    80002998:	00813403          	ld	s0,8(sp)
    8000299c:	01010113          	addi	sp,sp,16
    800029a0:	00008067          	ret

00000000800029a4 <_ZN14PeriodicThreadD0Ev>:
    800029a4:	ff010113          	addi	sp,sp,-16
    800029a8:	00113423          	sd	ra,8(sp)
    800029ac:	00813023          	sd	s0,0(sp)
    800029b0:	01010413          	addi	s0,sp,16
    800029b4:	00000097          	auipc	ra,0x0
    800029b8:	d04080e7          	jalr	-764(ra) # 800026b8 <_ZdlPv>
    800029bc:	00813083          	ld	ra,8(sp)
    800029c0:	00013403          	ld	s0,0(sp)
    800029c4:	01010113          	addi	sp,sp,16
    800029c8:	00008067          	ret

00000000800029cc <_ZN6ThreadD0Ev>:
    virtual ~Thread(){}
    800029cc:	ff010113          	addi	sp,sp,-16
    800029d0:	00113423          	sd	ra,8(sp)
    800029d4:	00813023          	sd	s0,0(sp)
    800029d8:	01010413          	addi	s0,sp,16
    800029dc:	00000097          	auipc	ra,0x0
    800029e0:	cdc080e7          	jalr	-804(ra) # 800026b8 <_ZdlPv>
    800029e4:	00813083          	ld	ra,8(sp)
    800029e8:	00013403          	ld	s0,0(sp)
    800029ec:	01010113          	addi	sp,sp,16
    800029f0:	00008067          	ret

00000000800029f4 <_ZN12OutputBuffer18createOutputBufferEv>:
#include "../h/outputBuffer.hpp"

OutputBuffer* OutputBuffer::outputBuffer = nullptr;

void OutputBuffer::createOutputBuffer() {
    800029f4:	fe010113          	addi	sp,sp,-32
    800029f8:	00113c23          	sd	ra,24(sp)
    800029fc:	00813823          	sd	s0,16(sp)
    80002a00:	00913423          	sd	s1,8(sp)
    80002a04:	01213023          	sd	s2,0(sp)
    80002a08:	02010413          	addi	s0,sp,32

    int get() override;

    void* operator new(size_t sz){
        sz = (sz + sizeof(size_t))/MEM_BLOCK_SIZE + (((sz + sizeof(size_t))%MEM_BLOCK_SIZE)==0?0:1);
        return MemoryAllocator::kmem_alloc(sz);
    80002a0c:	00200513          	li	a0,2
    80002a10:	00000097          	auipc	ra,0x0
    80002a14:	744080e7          	jalr	1860(ra) # 80003154 <_ZN15MemoryAllocator10kmem_allocEm>
    80002a18:	00050493          	mv	s1,a0
    OutputBuffer(int cap) : ConsoleBuffer(cap) {}
    80002a1c:	000015b7          	lui	a1,0x1
    80002a20:	80058593          	addi	a1,a1,-2048 # 800 <_entry-0x7ffff800>
    80002a24:	fffff097          	auipc	ra,0xfffff
    80002a28:	fe4080e7          	jalr	-28(ra) # 80001a08 <_ZN13ConsoleBufferC1Ei>
    80002a2c:	00005797          	auipc	a5,0x5
    80002a30:	95c78793          	addi	a5,a5,-1700 # 80007388 <_ZTV12OutputBuffer+0x10>
    80002a34:	00f4b023          	sd	a5,0(s1)
    outputBuffer = new OutputBuffer(2048);
    80002a38:	00005797          	auipc	a5,0x5
    80002a3c:	a497b823          	sd	s1,-1456(a5) # 80007488 <_ZN12OutputBuffer12outputBufferE>
}
    80002a40:	01813083          	ld	ra,24(sp)
    80002a44:	01013403          	ld	s0,16(sp)
    80002a48:	00813483          	ld	s1,8(sp)
    80002a4c:	00013903          	ld	s2,0(sp)
    80002a50:	02010113          	addi	sp,sp,32
    80002a54:	00008067          	ret
    80002a58:	00050913          	mv	s2,a0
    }

    void operator delete(void* arg){
        MemoryAllocator::kmem_free(arg);
    80002a5c:	00048513          	mv	a0,s1
    80002a60:	00000097          	auipc	ra,0x0
    80002a64:	7e4080e7          	jalr	2020(ra) # 80003244 <_ZN15MemoryAllocator9kmem_freeEPv>
    80002a68:	00090513          	mv	a0,s2
    80002a6c:	00006097          	auipc	ra,0x6
    80002a70:	b2c080e7          	jalr	-1236(ra) # 80008598 <_Unwind_Resume>

0000000080002a74 <_ZN12OutputBuffer18deleteOutputBufferEv>:

void OutputBuffer::deleteOutputBuffer() {
    delete outputBuffer;
    80002a74:	00005517          	auipc	a0,0x5
    80002a78:	a1453503          	ld	a0,-1516(a0) # 80007488 <_ZN12OutputBuffer12outputBufferE>
    80002a7c:	02050863          	beqz	a0,80002aac <_ZN12OutputBuffer18deleteOutputBufferEv+0x38>
void OutputBuffer::deleteOutputBuffer() {
    80002a80:	ff010113          	addi	sp,sp,-16
    80002a84:	00113423          	sd	ra,8(sp)
    80002a88:	00813023          	sd	s0,0(sp)
    80002a8c:	01010413          	addi	s0,sp,16
    delete outputBuffer;
    80002a90:	00053783          	ld	a5,0(a0)
    80002a94:	0087b783          	ld	a5,8(a5)
    80002a98:	000780e7          	jalr	a5
}
    80002a9c:	00813083          	ld	ra,8(sp)
    80002aa0:	00013403          	ld	s0,0(sp)
    80002aa4:	01010113          	addi	sp,sp,16
    80002aa8:	00008067          	ret
    80002aac:	00008067          	ret

0000000080002ab0 <_ZN12OutputBuffer3getEv>:

int OutputBuffer::get() {
    80002ab0:	fe010113          	addi	sp,sp,-32
    80002ab4:	00113c23          	sd	ra,24(sp)
    80002ab8:	00813823          	sd	s0,16(sp)
    80002abc:	00913423          	sd	s1,8(sp)
    80002ac0:	02010413          	addi	s0,sp,32
    80002ac4:	00050493          	mv	s1,a0
    if(getCnt()>0){
    80002ac8:	fffff097          	auipc	ra,0xfffff
    80002acc:	ff8080e7          	jalr	-8(ra) # 80001ac0 <_ZN13ConsoleBuffer6getCntEv>
    80002ad0:	02a05263          	blez	a0,80002af4 <_ZN12OutputBuffer3getEv+0x44>
        return ConsoleBuffer::get();
    80002ad4:	00048513          	mv	a0,s1
    80002ad8:	fffff097          	auipc	ra,0xfffff
    80002adc:	ea8080e7          	jalr	-344(ra) # 80001980 <_ZN13ConsoleBuffer3getEv>
    }
    else return 0;
}
    80002ae0:	01813083          	ld	ra,24(sp)
    80002ae4:	01013403          	ld	s0,16(sp)
    80002ae8:	00813483          	ld	s1,8(sp)
    80002aec:	02010113          	addi	sp,sp,32
    80002af0:	00008067          	ret
    else return 0;
    80002af4:	00000513          	li	a0,0
    80002af8:	fe9ff06f          	j	80002ae0 <_ZN12OutputBuffer3getEv+0x30>

0000000080002afc <_ZN12OutputBufferD1Ev>:
    ~OutputBuffer(){
    80002afc:	fe010113          	addi	sp,sp,-32
    80002b00:	00113c23          	sd	ra,24(sp)
    80002b04:	00813823          	sd	s0,16(sp)
    80002b08:	00913423          	sd	s1,8(sp)
    80002b0c:	02010413          	addi	s0,sp,32
    80002b10:	00050493          	mv	s1,a0
    80002b14:	00005797          	auipc	a5,0x5
    80002b18:	87478793          	addi	a5,a5,-1932 # 80007388 <_ZTV12OutputBuffer+0x10>
    80002b1c:	00f53023          	sd	a5,0(a0)
        kernelMode();
    80002b20:	fffff097          	auipc	ra,0xfffff
    80002b24:	ca0080e7          	jalr	-864(ra) # 800017c0 <_Z10kernelModev>
    __asm__ volatile("csrs sstatus, %[mask]" : : [mask] "r"(mask));
}

inline void Riscv::mc_sstatus(uint64 mask) {
    __asm__ volatile("csrc sstatus, %[mask]" : : [mask] "r"(mask));
}
    80002b28:	00200793          	li	a5,2
    80002b2c:	1007b073          	csrc	sstatus,a5
        while((*((char*)CONSOLE_STATUS)&CONSOLE_TX_STATUS_BIT)){
    80002b30:	00005797          	auipc	a5,0x5
    80002b34:	8887b783          	ld	a5,-1912(a5) # 800073b8 <_GLOBAL_OFFSET_TABLE_+0x10>
    80002b38:	0007b783          	ld	a5,0(a5)
    80002b3c:	0007c783          	lbu	a5,0(a5)
    80002b40:	0207f793          	andi	a5,a5,32
    80002b44:	02078863          	beqz	a5,80002b74 <_ZN12OutputBufferD1Ev+0x78>
            int val = OutputBuffer::outputBuffer->get();
    80002b48:	00005517          	auipc	a0,0x5
    80002b4c:	94053503          	ld	a0,-1728(a0) # 80007488 <_ZN12OutputBuffer12outputBufferE>
    80002b50:	00053783          	ld	a5,0(a0)
    80002b54:	0187b783          	ld	a5,24(a5)
    80002b58:	000780e7          	jalr	a5
            if(val == 0) break;
    80002b5c:	00050c63          	beqz	a0,80002b74 <_ZN12OutputBufferD1Ev+0x78>
            *((char*)CONSOLE_TX_DATA) = val;
    80002b60:	00005797          	auipc	a5,0x5
    80002b64:	8807b783          	ld	a5,-1920(a5) # 800073e0 <_GLOBAL_OFFSET_TABLE_+0x38>
    80002b68:	0007b783          	ld	a5,0(a5)
    80002b6c:	00a78023          	sb	a0,0(a5)
        while((*((char*)CONSOLE_STATUS)&CONSOLE_TX_STATUS_BIT)){
    80002b70:	fc1ff06f          	j	80002b30 <_ZN12OutputBufferD1Ev+0x34>
}
    80002b74:	00200793          	li	a5,2
    80002b78:	1007a073          	csrs	sstatus,a5
        userMode();
    80002b7c:	fffff097          	auipc	ra,0xfffff
    80002b80:	c08080e7          	jalr	-1016(ra) # 80001784 <_Z8userModev>
    ~OutputBuffer(){
    80002b84:	00048513          	mv	a0,s1
    80002b88:	fffff097          	auipc	ra,0xfffff
    80002b8c:	cb8080e7          	jalr	-840(ra) # 80001840 <_ZN13ConsoleBufferD1Ev>
    }
    80002b90:	01813083          	ld	ra,24(sp)
    80002b94:	01013403          	ld	s0,16(sp)
    80002b98:	00813483          	ld	s1,8(sp)
    80002b9c:	02010113          	addi	sp,sp,32
    80002ba0:	00008067          	ret

0000000080002ba4 <_ZN12OutputBufferD0Ev>:
    ~OutputBuffer(){
    80002ba4:	fe010113          	addi	sp,sp,-32
    80002ba8:	00113c23          	sd	ra,24(sp)
    80002bac:	00813823          	sd	s0,16(sp)
    80002bb0:	00913423          	sd	s1,8(sp)
    80002bb4:	02010413          	addi	s0,sp,32
    80002bb8:	00050493          	mv	s1,a0
    80002bbc:	00004797          	auipc	a5,0x4
    80002bc0:	7cc78793          	addi	a5,a5,1996 # 80007388 <_ZTV12OutputBuffer+0x10>
    80002bc4:	00f53023          	sd	a5,0(a0)
        kernelMode();
    80002bc8:	fffff097          	auipc	ra,0xfffff
    80002bcc:	bf8080e7          	jalr	-1032(ra) # 800017c0 <_Z10kernelModev>
}
    80002bd0:	00200793          	li	a5,2
    80002bd4:	1007b073          	csrc	sstatus,a5
        while((*((char*)CONSOLE_STATUS)&CONSOLE_TX_STATUS_BIT)){
    80002bd8:	00004797          	auipc	a5,0x4
    80002bdc:	7e07b783          	ld	a5,2016(a5) # 800073b8 <_GLOBAL_OFFSET_TABLE_+0x10>
    80002be0:	0007b783          	ld	a5,0(a5)
    80002be4:	0007c783          	lbu	a5,0(a5)
    80002be8:	0207f793          	andi	a5,a5,32
    80002bec:	02078863          	beqz	a5,80002c1c <_ZN12OutputBufferD0Ev+0x78>
            int val = OutputBuffer::outputBuffer->get();
    80002bf0:	00005517          	auipc	a0,0x5
    80002bf4:	89853503          	ld	a0,-1896(a0) # 80007488 <_ZN12OutputBuffer12outputBufferE>
    80002bf8:	00053783          	ld	a5,0(a0)
    80002bfc:	0187b783          	ld	a5,24(a5)
    80002c00:	000780e7          	jalr	a5
            if(val == 0) break;
    80002c04:	00050c63          	beqz	a0,80002c1c <_ZN12OutputBufferD0Ev+0x78>
            *((char*)CONSOLE_TX_DATA) = val;
    80002c08:	00004797          	auipc	a5,0x4
    80002c0c:	7d87b783          	ld	a5,2008(a5) # 800073e0 <_GLOBAL_OFFSET_TABLE_+0x38>
    80002c10:	0007b783          	ld	a5,0(a5)
    80002c14:	00a78023          	sb	a0,0(a5)
        while((*((char*)CONSOLE_STATUS)&CONSOLE_TX_STATUS_BIT)){
    80002c18:	fc1ff06f          	j	80002bd8 <_ZN12OutputBufferD0Ev+0x34>
}
    80002c1c:	00200793          	li	a5,2
    80002c20:	1007a073          	csrs	sstatus,a5
        userMode();
    80002c24:	fffff097          	auipc	ra,0xfffff
    80002c28:	b60080e7          	jalr	-1184(ra) # 80001784 <_Z8userModev>
    ~OutputBuffer(){
    80002c2c:	00048513          	mv	a0,s1
    80002c30:	fffff097          	auipc	ra,0xfffff
    80002c34:	c10080e7          	jalr	-1008(ra) # 80001840 <_ZN13ConsoleBufferD1Ev>
        MemoryAllocator::kmem_free(arg);
    80002c38:	00048513          	mv	a0,s1
    80002c3c:	00000097          	auipc	ra,0x0
    80002c40:	608080e7          	jalr	1544(ra) # 80003244 <_ZN15MemoryAllocator9kmem_freeEPv>
    }
    80002c44:	01813083          	ld	ra,24(sp)
    80002c48:	01013403          	ld	s0,16(sp)
    80002c4c:	00813483          	ld	s1,8(sp)
    80002c50:	02010113          	addi	sp,sp,32
    80002c54:	00008067          	ret

0000000080002c58 <_Z41__static_initialization_and_destruction_0ii>:
    return readyThreadQueue.removeFirst();
}

void Scheduler::put(_thread*t){
    readyThreadQueue.addLast(t);
}
    80002c58:	ff010113          	addi	sp,sp,-16
    80002c5c:	00813423          	sd	s0,8(sp)
    80002c60:	01010413          	addi	s0,sp,16
    80002c64:	00100793          	li	a5,1
    80002c68:	00f50863          	beq	a0,a5,80002c78 <_Z41__static_initialization_and_destruction_0ii+0x20>
    80002c6c:	00813403          	ld	s0,8(sp)
    80002c70:	01010113          	addi	sp,sp,16
    80002c74:	00008067          	ret
    80002c78:	000107b7          	lui	a5,0x10
    80002c7c:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80002c80:	fef596e3          	bne	a1,a5,80002c6c <_Z41__static_initialization_and_destruction_0ii+0x14>
    };

public:
    Elem* head, *tail;

    List() : head(nullptr), tail(nullptr) {}
    80002c84:	00005797          	auipc	a5,0x5
    80002c88:	80c78793          	addi	a5,a5,-2036 # 80007490 <_ZN9Scheduler16readyThreadQueueE>
    80002c8c:	0007b023          	sd	zero,0(a5)
    80002c90:	0007b423          	sd	zero,8(a5)
    80002c94:	fd9ff06f          	j	80002c6c <_Z41__static_initialization_and_destruction_0ii+0x14>

0000000080002c98 <_ZN9Scheduler3getEv>:
_thread* Scheduler::get(){
    80002c98:	fe010113          	addi	sp,sp,-32
    80002c9c:	00113c23          	sd	ra,24(sp)
    80002ca0:	00813823          	sd	s0,16(sp)
    80002ca4:	00913423          	sd	s1,8(sp)
    80002ca8:	02010413          	addi	s0,sp,32
            head = tail = novi;
    }

    T removeFirst() {
        //if (!head) return nullptr;
        if(!head) return 0;
    80002cac:	00004517          	auipc	a0,0x4
    80002cb0:	7e453503          	ld	a0,2020(a0) # 80007490 <_ZN9Scheduler16readyThreadQueueE>
    80002cb4:	04050263          	beqz	a0,80002cf8 <_ZN9Scheduler3getEv+0x60>
        Elem* elem = head;
        head = head->next;
    80002cb8:	00053783          	ld	a5,0(a0)
    80002cbc:	00004717          	auipc	a4,0x4
    80002cc0:	7cf73a23          	sd	a5,2004(a4) # 80007490 <_ZN9Scheduler16readyThreadQueueE>
        if (!head) tail = nullptr;
    80002cc4:	02078463          	beqz	a5,80002cec <_ZN9Scheduler3getEv+0x54>
        T data = elem->data;
    80002cc8:	00853483          	ld	s1,8(a0)
        MemoryAllocator::kmem_free(elem);
    80002ccc:	00000097          	auipc	ra,0x0
    80002cd0:	578080e7          	jalr	1400(ra) # 80003244 <_ZN15MemoryAllocator9kmem_freeEPv>
}
    80002cd4:	00048513          	mv	a0,s1
    80002cd8:	01813083          	ld	ra,24(sp)
    80002cdc:	01013403          	ld	s0,16(sp)
    80002ce0:	00813483          	ld	s1,8(sp)
    80002ce4:	02010113          	addi	sp,sp,32
    80002ce8:	00008067          	ret
        if (!head) tail = nullptr;
    80002cec:	00004797          	auipc	a5,0x4
    80002cf0:	7a07b623          	sd	zero,1964(a5) # 80007498 <_ZN9Scheduler16readyThreadQueueE+0x8>
    80002cf4:	fd5ff06f          	j	80002cc8 <_ZN9Scheduler3getEv+0x30>
        if(!head) return 0;
    80002cf8:	00050493          	mv	s1,a0
    return readyThreadQueue.removeFirst();
    80002cfc:	fd9ff06f          	j	80002cd4 <_ZN9Scheduler3getEv+0x3c>

0000000080002d00 <_ZN9Scheduler3putEP7_thread>:
void Scheduler::put(_thread*t){
    80002d00:	fe010113          	addi	sp,sp,-32
    80002d04:	00113c23          	sd	ra,24(sp)
    80002d08:	00813823          	sd	s0,16(sp)
    80002d0c:	00913423          	sd	s1,8(sp)
    80002d10:	02010413          	addi	s0,sp,32
    80002d14:	00050493          	mv	s1,a0
        Elem* novi = (Elem*) MemoryAllocator::kmem_alloc(sz);
    80002d18:	00100513          	li	a0,1
    80002d1c:	00000097          	auipc	ra,0x0
    80002d20:	438080e7          	jalr	1080(ra) # 80003154 <_ZN15MemoryAllocator10kmem_allocEm>
        novi->data = data; novi->next = nullptr;
    80002d24:	00953423          	sd	s1,8(a0)
    80002d28:	00053023          	sd	zero,0(a0)
        if (tail) {
    80002d2c:	00004797          	auipc	a5,0x4
    80002d30:	76c7b783          	ld	a5,1900(a5) # 80007498 <_ZN9Scheduler16readyThreadQueueE+0x8>
    80002d34:	02078263          	beqz	a5,80002d58 <_ZN9Scheduler3putEP7_thread+0x58>
            tail->next = novi;
    80002d38:	00a7b023          	sd	a0,0(a5)
            tail = novi;
    80002d3c:	00004797          	auipc	a5,0x4
    80002d40:	74a7be23          	sd	a0,1884(a5) # 80007498 <_ZN9Scheduler16readyThreadQueueE+0x8>
}
    80002d44:	01813083          	ld	ra,24(sp)
    80002d48:	01013403          	ld	s0,16(sp)
    80002d4c:	00813483          	ld	s1,8(sp)
    80002d50:	02010113          	addi	sp,sp,32
    80002d54:	00008067          	ret
            head = tail = novi;
    80002d58:	00004797          	auipc	a5,0x4
    80002d5c:	73878793          	addi	a5,a5,1848 # 80007490 <_ZN9Scheduler16readyThreadQueueE>
    80002d60:	00a7b423          	sd	a0,8(a5)
    80002d64:	00a7b023          	sd	a0,0(a5)
    80002d68:	fddff06f          	j	80002d44 <_ZN9Scheduler3putEP7_thread+0x44>

0000000080002d6c <_GLOBAL__sub_I__ZN9Scheduler16readyThreadQueueE>:
    80002d6c:	ff010113          	addi	sp,sp,-16
    80002d70:	00113423          	sd	ra,8(sp)
    80002d74:	00813023          	sd	s0,0(sp)
    80002d78:	01010413          	addi	s0,sp,16
    80002d7c:	000105b7          	lui	a1,0x10
    80002d80:	fff58593          	addi	a1,a1,-1 # ffff <_entry-0x7fff0001>
    80002d84:	00100513          	li	a0,1
    80002d88:	00000097          	auipc	ra,0x0
    80002d8c:	ed0080e7          	jalr	-304(ra) # 80002c58 <_Z41__static_initialization_and_destruction_0ii>
    80002d90:	00813083          	ld	ra,8(sp)
    80002d94:	00013403          	ld	s0,0(sp)
    80002d98:	01010113          	addi	sp,sp,16
    80002d9c:	00008067          	ret

0000000080002da0 <_ZN10sleepQueue3putEP7_thread>:

sleepQueue::Elem *sleepQueue::head = nullptr;
sleepQueue::Elem *sleepQueue::tail = nullptr;


void sleepQueue::put(_thread*t){
    80002da0:	fe010113          	addi	sp,sp,-32
    80002da4:	00113c23          	sd	ra,24(sp)
    80002da8:	00813823          	sd	s0,16(sp)
    80002dac:	00913423          	sd	s1,8(sp)
    80002db0:	02010413          	addi	s0,sp,32
    80002db4:	00050493          	mv	s1,a0
    size_t sz = (sizeof(Elem)+sizeof(size_t))/MEM_BLOCK_SIZE + (((sizeof(Elem)+sizeof(size_t))%MEM_BLOCK_SIZE)==0?0:1);
    Elem* novi =(Elem*) MemoryAllocator::kmem_alloc(sz);
    80002db8:	00100513          	li	a0,1
    80002dbc:	00000097          	auipc	ra,0x0
    80002dc0:	398080e7          	jalr	920(ra) # 80003154 <_ZN15MemoryAllocator10kmem_allocEm>
    novi->thread = t; novi->next = nullptr;
    80002dc4:	00953423          	sd	s1,8(a0)
    80002dc8:	00053023          	sd	zero,0(a0)
    if (tail) {
    80002dcc:	00004797          	auipc	a5,0x4
    80002dd0:	6d47b783          	ld	a5,1748(a5) # 800074a0 <_ZN10sleepQueue4tailE>
    80002dd4:	02078263          	beqz	a5,80002df8 <_ZN10sleepQueue3putEP7_thread+0x58>
        tail->next = novi;
    80002dd8:	00a7b023          	sd	a0,0(a5)
        tail = novi;
    80002ddc:	00004797          	auipc	a5,0x4
    80002de0:	6ca7b223          	sd	a0,1732(a5) # 800074a0 <_ZN10sleepQueue4tailE>
    }
    else
        head = tail = novi;
}
    80002de4:	01813083          	ld	ra,24(sp)
    80002de8:	01013403          	ld	s0,16(sp)
    80002dec:	00813483          	ld	s1,8(sp)
    80002df0:	02010113          	addi	sp,sp,32
    80002df4:	00008067          	ret
        head = tail = novi;
    80002df8:	00004797          	auipc	a5,0x4
    80002dfc:	6a878793          	addi	a5,a5,1704 # 800074a0 <_ZN10sleepQueue4tailE>
    80002e00:	00a7b023          	sd	a0,0(a5)
    80002e04:	00a7b423          	sd	a0,8(a5)
}
    80002e08:	fddff06f          	j	80002de4 <_ZN10sleepQueue3putEP7_thread+0x44>

0000000080002e0c <_ZN10sleepQueue7iterateEv>:

void sleepQueue::iterate() {
    80002e0c:	fd010113          	addi	sp,sp,-48
    80002e10:	02113423          	sd	ra,40(sp)
    80002e14:	02813023          	sd	s0,32(sp)
    80002e18:	00913c23          	sd	s1,24(sp)
    80002e1c:	01213823          	sd	s2,16(sp)
    80002e20:	01313423          	sd	s3,8(sp)
    80002e24:	03010413          	addi	s0,sp,48
    Elem* q = nullptr, *p = head, *old = nullptr;
    80002e28:	00004497          	auipc	s1,0x4
    80002e2c:	6804b483          	ld	s1,1664(s1) # 800074a8 <_ZN10sleepQueue4headE>
    80002e30:	00000913          	li	s2,0
    80002e34:	0300006f          	j	80002e64 <_ZN10sleepQueue7iterateEv+0x58>
    while(p){
        p->thread->decTimeToSleep();
        uint64 time = p->thread->getTimeToSleep();
        if(time == 0){
            old = p;
            Scheduler::put(p->thread);
    80002e38:	00000097          	auipc	ra,0x0
    80002e3c:	ec8080e7          	jalr	-312(ra) # 80002d00 <_ZN9Scheduler3putEP7_thread>
            if(q == nullptr){
    80002e40:	04090863          	beqz	s2,80002e90 <_ZN10sleepQueue7iterateEv+0x84>
                head = p->next;
                if(head == nullptr) {tail = nullptr; MemoryAllocator::kmem_free(old); break;}
                else {p = head;}
            }
            else{
                q->next = p->next;
    80002e44:	0004b783          	ld	a5,0(s1)
    80002e48:	00f93023          	sd	a5,0(s2)
                if(q->next == nullptr) tail = q;
    80002e4c:	08078263          	beqz	a5,80002ed0 <_ZN10sleepQueue7iterateEv+0xc4>
                p = p->next;
    80002e50:	0004b983          	ld	s3,0(s1)
            }
            MemoryAllocator::kmem_free(old);
    80002e54:	00048513          	mv	a0,s1
    80002e58:	00000097          	auipc	ra,0x0
    80002e5c:	3ec080e7          	jalr	1004(ra) # 80003244 <_ZN15MemoryAllocator9kmem_freeEPv>
    80002e60:	00098493          	mv	s1,s3
    while(p){
    80002e64:	04048863          	beqz	s1,80002eb4 <_ZN10sleepQueue7iterateEv+0xa8>
        p->thread->decTimeToSleep();
    80002e68:	0084b703          	ld	a4,8(s1)
    void decTimeToSleep() { timeToSleep--; }
    80002e6c:	03873783          	ld	a5,56(a4)
    80002e70:	fff78793          	addi	a5,a5,-1
    80002e74:	02f73c23          	sd	a5,56(a4)
        uint64 time = p->thread->getTimeToSleep();
    80002e78:	0084b503          	ld	a0,8(s1)
    uint64 getTimeToSleep() const { return timeToSleep; }
    80002e7c:	03853783          	ld	a5,56(a0)
        if(time == 0){
    80002e80:	fa078ce3          	beqz	a5,80002e38 <_ZN10sleepQueue7iterateEv+0x2c>
        }
        else {
            q = p;
    80002e84:	00048913          	mv	s2,s1
            p = p->next;
    80002e88:	0004b483          	ld	s1,0(s1)
    80002e8c:	fd9ff06f          	j	80002e64 <_ZN10sleepQueue7iterateEv+0x58>
                head = p->next;
    80002e90:	0004b983          	ld	s3,0(s1)
    80002e94:	00004797          	auipc	a5,0x4
    80002e98:	6137ba23          	sd	s3,1556(a5) # 800074a8 <_ZN10sleepQueue4headE>
                if(head == nullptr) {tail = nullptr; MemoryAllocator::kmem_free(old); break;}
    80002e9c:	fa099ce3          	bnez	s3,80002e54 <_ZN10sleepQueue7iterateEv+0x48>
    80002ea0:	00004797          	auipc	a5,0x4
    80002ea4:	6007b023          	sd	zero,1536(a5) # 800074a0 <_ZN10sleepQueue4tailE>
    80002ea8:	00048513          	mv	a0,s1
    80002eac:	00000097          	auipc	ra,0x0
    80002eb0:	398080e7          	jalr	920(ra) # 80003244 <_ZN15MemoryAllocator9kmem_freeEPv>
        }
    }
    80002eb4:	02813083          	ld	ra,40(sp)
    80002eb8:	02013403          	ld	s0,32(sp)
    80002ebc:	01813483          	ld	s1,24(sp)
    80002ec0:	01013903          	ld	s2,16(sp)
    80002ec4:	00813983          	ld	s3,8(sp)
    80002ec8:	03010113          	addi	sp,sp,48
    80002ecc:	00008067          	ret
                if(q->next == nullptr) tail = q;
    80002ed0:	00004797          	auipc	a5,0x4
    80002ed4:	5d27b823          	sd	s2,1488(a5) # 800074a0 <_ZN10sleepQueue4tailE>
    80002ed8:	f79ff06f          	j	80002e50 <_ZN10sleepQueue7iterateEv+0x44>

0000000080002edc <_ZN7_thread13threadWrapperEv>:
    if (!old->isFinished() && flag == 0) { Scheduler::put(old); }
    running = Scheduler::get();
    _thread::contextSwitch(&old->context, &running->context);
}

void _thread::threadWrapper() {
    80002edc:	ff010113          	addi	sp,sp,-16
    80002ee0:	00113423          	sd	ra,8(sp)
    80002ee4:	00813023          	sd	s0,0(sp)
    80002ee8:	01010413          	addi	s0,sp,16
    Riscv::popSppSpie();
    80002eec:	fffff097          	auipc	ra,0xfffff
    80002ef0:	13c080e7          	jalr	316(ra) # 80002028 <_ZN5Riscv10popSppSpieEv>
    running->body(running->arg);
    80002ef4:	00004797          	auipc	a5,0x4
    80002ef8:	5bc7b783          	ld	a5,1468(a5) # 800074b0 <_ZN7_thread7runningE>
    80002efc:	0107b703          	ld	a4,16(a5)
    80002f00:	0187b503          	ld	a0,24(a5)
    80002f04:	000700e7          	jalr	a4
    thread_exit();
    80002f08:	ffffe097          	auipc	ra,0xffffe
    80002f0c:	574080e7          	jalr	1396(ra) # 8000147c <_Z11thread_exitv>
}
    80002f10:	00813083          	ld	ra,8(sp)
    80002f14:	00013403          	ld	s0,0(sp)
    80002f18:	01010113          	addi	sp,sp,16
    80002f1c:	00008067          	ret

0000000080002f20 <_ZN7_thread12createThreadEPPS_PFvPvES2_Pmi>:
int _thread::createThread(thread_t* handle, Body body, void*arg, uint64*stek, int flag) {
    80002f20:	fc010113          	addi	sp,sp,-64
    80002f24:	02113c23          	sd	ra,56(sp)
    80002f28:	02813823          	sd	s0,48(sp)
    80002f2c:	02913423          	sd	s1,40(sp)
    80002f30:	03213023          	sd	s2,32(sp)
    80002f34:	01313c23          	sd	s3,24(sp)
    80002f38:	01413823          	sd	s4,16(sp)
    80002f3c:	01513423          	sd	s5,8(sp)
    80002f40:	01613023          	sd	s6,0(sp)
    80002f44:	04010413          	addi	s0,sp,64
    80002f48:	00050a13          	mv	s4,a0
    80002f4c:	00058993          	mv	s3,a1
    80002f50:	00060a93          	mv	s5,a2
    80002f54:	00068913          	mv	s2,a3
    80002f58:	00070b13          	mv	s6,a4
    thread_t thread = (thread_t)(MemoryAllocator::kmem_alloc(sz));
    80002f5c:	00200513          	li	a0,2
    80002f60:	00000097          	auipc	ra,0x0
    80002f64:	1f4080e7          	jalr	500(ra) # 80003154 <_ZN15MemoryAllocator10kmem_allocEm>
    80002f68:	00050493          	mv	s1,a0
    thread->body = body;
    80002f6c:	01353823          	sd	s3,16(a0)
    thread->arg = arg;
    80002f70:	01553c23          	sd	s5,24(a0)
    thread->timeSlice = DEFAULT_TIME_SLICE;
    80002f74:	00200793          	li	a5,2
    80002f78:	02f53423          	sd	a5,40(a0)
    thread->finished = false;
    80002f7c:	02050823          	sb	zero,48(a0)
    thread->timeToSleep = 0;
    80002f80:	02053c23          	sd	zero,56(a0)
    if (thread->body !=nullptr) {
    80002f84:	06098063          	beqz	s3,80002fe4 <_ZN7_thread12createThreadEPPS_PFvPvES2_Pmi+0xc4>
        thread->context.ra = (uint64) &threadWrapper;
    80002f88:	00000797          	auipc	a5,0x0
    80002f8c:	f5478793          	addi	a5,a5,-172 # 80002edc <_ZN7_thread13threadWrapperEv>
    80002f90:	00f53023          	sd	a5,0(a0)
        thread->stack = stek;
    80002f94:	03253023          	sd	s2,32(a0)
        thread->context.sp = (uint64) &thread->stack[DEFAULT_STACK_SIZE];
    80002f98:	000086b7          	lui	a3,0x8
    80002f9c:	00d90933          	add	s2,s2,a3
    80002fa0:	01253423          	sd	s2,8(a0)
        if(flag) Scheduler::put(thread);
    80002fa4:	020b1a63          	bnez	s6,80002fd8 <_ZN7_thread12createThreadEPPS_PFvPvES2_Pmi+0xb8>
    *handle = thread;
    80002fa8:	009a3023          	sd	s1,0(s4)
}
    80002fac:	00000513          	li	a0,0
    80002fb0:	03813083          	ld	ra,56(sp)
    80002fb4:	03013403          	ld	s0,48(sp)
    80002fb8:	02813483          	ld	s1,40(sp)
    80002fbc:	02013903          	ld	s2,32(sp)
    80002fc0:	01813983          	ld	s3,24(sp)
    80002fc4:	01013a03          	ld	s4,16(sp)
    80002fc8:	00813a83          	ld	s5,8(sp)
    80002fcc:	00013b03          	ld	s6,0(sp)
    80002fd0:	04010113          	addi	sp,sp,64
    80002fd4:	00008067          	ret
        if(flag) Scheduler::put(thread);
    80002fd8:	00000097          	auipc	ra,0x0
    80002fdc:	d28080e7          	jalr	-728(ra) # 80002d00 <_ZN9Scheduler3putEP7_thread>
    80002fe0:	fc9ff06f          	j	80002fa8 <_ZN7_thread12createThreadEPPS_PFvPvES2_Pmi+0x88>
        thread->context.ra = 0;
    80002fe4:	00053023          	sd	zero,0(a0)
        thread->context.sp = 0;
    80002fe8:	00053423          	sd	zero,8(a0)
        thread->stack = nullptr;
    80002fec:	02053023          	sd	zero,32(a0)
    80002ff0:	fb9ff06f          	j	80002fa8 <_ZN7_thread12createThreadEPPS_PFvPvES2_Pmi+0x88>

0000000080002ff4 <_ZN7_thread9kdispatchEi>:
void _thread::kdispatch(int flag) {
    80002ff4:	fe010113          	addi	sp,sp,-32
    80002ff8:	00113c23          	sd	ra,24(sp)
    80002ffc:	00813823          	sd	s0,16(sp)
    80003000:	00913423          	sd	s1,8(sp)
    80003004:	02010413          	addi	s0,sp,32
    _thread *old = running;
    80003008:	00004497          	auipc	s1,0x4
    8000300c:	4a84b483          	ld	s1,1192(s1) # 800074b0 <_ZN7_thread7runningE>
    bool isFinished() const { return finished; }
    80003010:	0304c783          	lbu	a5,48(s1)
    if (!old->isFinished() && flag == 0) { Scheduler::put(old); }
    80003014:	00079463          	bnez	a5,8000301c <_ZN7_thread9kdispatchEi+0x28>
    80003018:	02050c63          	beqz	a0,80003050 <_ZN7_thread9kdispatchEi+0x5c>
    running = Scheduler::get();
    8000301c:	00000097          	auipc	ra,0x0
    80003020:	c7c080e7          	jalr	-900(ra) # 80002c98 <_ZN9Scheduler3getEv>
    80003024:	00050593          	mv	a1,a0
    80003028:	00004797          	auipc	a5,0x4
    8000302c:	48a7b423          	sd	a0,1160(a5) # 800074b0 <_ZN7_thread7runningE>
    _thread::contextSwitch(&old->context, &running->context);
    80003030:	00048513          	mv	a0,s1
    80003034:	ffffe097          	auipc	ra,0xffffe
    80003038:	fec080e7          	jalr	-20(ra) # 80001020 <_ZN7_thread13contextSwitchEPNS_7ContextES1_>
}
    8000303c:	01813083          	ld	ra,24(sp)
    80003040:	01013403          	ld	s0,16(sp)
    80003044:	00813483          	ld	s1,8(sp)
    80003048:	02010113          	addi	sp,sp,32
    8000304c:	00008067          	ret
    if (!old->isFinished() && flag == 0) { Scheduler::put(old); }
    80003050:	00048513          	mv	a0,s1
    80003054:	00000097          	auipc	ra,0x0
    80003058:	cac080e7          	jalr	-852(ra) # 80002d00 <_ZN9Scheduler3putEP7_thread>
    8000305c:	fc1ff06f          	j	8000301c <_ZN7_thread9kdispatchEi+0x28>

0000000080003060 <_ZN7_thread5sleepEm>:
    if(time == 0) return 0;
    80003060:	00051663          	bnez	a0,8000306c <_ZN7_thread5sleepEm+0xc>
}
    80003064:	00000513          	li	a0,0
    80003068:	00008067          	ret
int _thread::sleep(time_t time) {
    8000306c:	fe010113          	addi	sp,sp,-32
    80003070:	00113c23          	sd	ra,24(sp)
    80003074:	00813823          	sd	s0,16(sp)
    80003078:	00913423          	sd	s1,8(sp)
    8000307c:	02010413          	addi	s0,sp,32
    80003080:	00050793          	mv	a5,a0
    _thread::running->timeToSleep = time;
    80003084:	00004497          	auipc	s1,0x4
    80003088:	42c48493          	addi	s1,s1,1068 # 800074b0 <_ZN7_thread7runningE>
    8000308c:	0004b503          	ld	a0,0(s1)
    80003090:	02f53c23          	sd	a5,56(a0)
    sleepQueue::put(_thread::running);
    80003094:	00000097          	auipc	ra,0x0
    80003098:	d0c080e7          	jalr	-756(ra) # 80002da0 <_ZN10sleepQueue3putEP7_thread>
    timeSliceCounter = 0;
    8000309c:	0004b423          	sd	zero,8(s1)
    kdispatch(1);
    800030a0:	00100513          	li	a0,1
    800030a4:	00000097          	auipc	ra,0x0
    800030a8:	f50080e7          	jalr	-176(ra) # 80002ff4 <_ZN7_thread9kdispatchEi>
}
    800030ac:	00000513          	li	a0,0
    800030b0:	01813083          	ld	ra,24(sp)
    800030b4:	01013403          	ld	s0,16(sp)
    800030b8:	00813483          	ld	s1,8(sp)
    800030bc:	02010113          	addi	sp,sp,32
    800030c0:	00008067          	ret

00000000800030c4 <_ZN7_thread14addToSchedulerEPS_>:

void _thread::addToScheduler(thread_t t) {
    800030c4:	ff010113          	addi	sp,sp,-16
    800030c8:	00113423          	sd	ra,8(sp)
    800030cc:	00813023          	sd	s0,0(sp)
    800030d0:	01010413          	addi	s0,sp,16
    Scheduler::put(t);
    800030d4:	00000097          	auipc	ra,0x0
    800030d8:	c2c080e7          	jalr	-980(ra) # 80002d00 <_ZN9Scheduler3putEP7_thread>
}
    800030dc:	00813083          	ld	ra,8(sp)
    800030e0:	00013403          	ld	s0,0(sp)
    800030e4:	01010113          	addi	sp,sp,16
    800030e8:	00008067          	ret

00000000800030ec <_ZN15MemoryAllocator11kinitMemoryEv>:
#include "../h/memory.hpp"

MemoryAllocator::Elem* MemoryAllocator::head = nullptr;

void MemoryAllocator::kinitMemory() {
    800030ec:	ff010113          	addi	sp,sp,-16
    800030f0:	00813423          	sd	s0,8(sp)
    800030f4:	01010413          	addi	s0,sp,16
    head = (Elem*)HEAP_START_ADDR;
    800030f8:	00004717          	auipc	a4,0x4
    800030fc:	2d073703          	ld	a4,720(a4) # 800073c8 <_GLOBAL_OFFSET_TABLE_+0x20>
    80003100:	00073783          	ld	a5,0(a4)
    80003104:	00004697          	auipc	a3,0x4
    80003108:	3bc68693          	addi	a3,a3,956 # 800074c0 <_ZN15MemoryAllocator4headE>
    8000310c:	00f6b023          	sd	a5,0(a3)
    head->next = head->prev = nullptr;
    80003110:	0007b423          	sd	zero,8(a5)
    80003114:	0007b023          	sd	zero,0(a5)
    head->numbersOfBlocks = ((char*)HEAP_END_ADDR - (char*)HEAP_START_ADDR - sizeof(size_t)) / MEM_BLOCK_SIZE + (((((char*)HEAP_END_ADDR - (char*)HEAP_START_ADDR - sizeof(size_t))%MEM_BLOCK_SIZE)==0)?0:1);
    80003118:	00004797          	auipc	a5,0x4
    8000311c:	2d87b783          	ld	a5,728(a5) # 800073f0 <_GLOBAL_OFFSET_TABLE_+0x48>
    80003120:	0007b783          	ld	a5,0(a5)
    80003124:	00073703          	ld	a4,0(a4)
    80003128:	40e787b3          	sub	a5,a5,a4
    8000312c:	ff878793          	addi	a5,a5,-8
    80003130:	0067d713          	srli	a4,a5,0x6
    80003134:	03f7f793          	andi	a5,a5,63
    80003138:	00f037b3          	snez	a5,a5
    8000313c:	0006b683          	ld	a3,0(a3)
    80003140:	00f707b3          	add	a5,a4,a5
    80003144:	00f6b823          	sd	a5,16(a3)
}
    80003148:	00813403          	ld	s0,8(sp)
    8000314c:	01010113          	addi	sp,sp,16
    80003150:	00008067          	ret

0000000080003154 <_ZN15MemoryAllocator10kmem_allocEm>:
void* MemoryAllocator::kmem_alloc(size_t numOfBlocks) {
    80003154:	ff010113          	addi	sp,sp,-16
    80003158:	00813423          	sd	s0,8(sp)
    8000315c:	01010413          	addi	s0,sp,16
    80003160:	00050693          	mv	a3,a0
    Elem* blockToAllocate = nullptr;
    size_t minimum = 0;
    Elem* curr = head;
    80003164:	00004797          	auipc	a5,0x4
    80003168:	35c7b783          	ld	a5,860(a5) # 800074c0 <_ZN15MemoryAllocator4headE>
    size_t minimum = 0;
    8000316c:	00000613          	li	a2,0
    Elem* blockToAllocate = nullptr;
    80003170:	00000513          	li	a0,0
    80003174:	0100006f          	j	80003184 <_ZN15MemoryAllocator10kmem_allocEm+0x30>
    while (curr) {
        if (curr->numbersOfBlocks >= numOfBlocks) {
            if (curr->numbersOfBlocks - numOfBlocks < minimum || !blockToAllocate) {
                blockToAllocate = curr;
                minimum = curr->numbersOfBlocks - numOfBlocks;
    80003178:	00070613          	mv	a2,a4
                blockToAllocate = curr;
    8000317c:	00078513          	mv	a0,a5
            }
        }
        curr = curr->next;
    80003180:	0007b783          	ld	a5,0(a5)
    while (curr) {
    80003184:	02078263          	beqz	a5,800031a8 <_ZN15MemoryAllocator10kmem_allocEm+0x54>
        if (curr->numbersOfBlocks >= numOfBlocks) {
    80003188:	0107b703          	ld	a4,16(a5)
    8000318c:	fed76ae3          	bltu	a4,a3,80003180 <_ZN15MemoryAllocator10kmem_allocEm+0x2c>
            if (curr->numbersOfBlocks - numOfBlocks < minimum || !blockToAllocate) {
    80003190:	40d70733          	sub	a4,a4,a3
    80003194:	fec762e3          	bltu	a4,a2,80003178 <_ZN15MemoryAllocator10kmem_allocEm+0x24>
    80003198:	fe0514e3          	bnez	a0,80003180 <_ZN15MemoryAllocator10kmem_allocEm+0x2c>
                minimum = curr->numbersOfBlocks - numOfBlocks;
    8000319c:	00070613          	mv	a2,a4
                blockToAllocate = curr;
    800031a0:	00078513          	mv	a0,a5
    800031a4:	fddff06f          	j	80003180 <_ZN15MemoryAllocator10kmem_allocEm+0x2c>
    }
    if (!blockToAllocate) return nullptr;
    800031a8:	08050263          	beqz	a0,8000322c <_ZN15MemoryAllocator10kmem_allocEm+0xd8>
    size_t remaining = blockToAllocate->numbersOfBlocks - numOfBlocks;
    800031ac:	01053783          	ld	a5,16(a0)
    800031b0:	40d78733          	sub	a4,a5,a3
    if (remaining == 0) {
    800031b4:	02d79e63          	bne	a5,a3,800031f0 <_ZN15MemoryAllocator10kmem_allocEm+0x9c>
        Elem* q = blockToAllocate->prev;
    800031b8:	00853783          	ld	a5,8(a0)
        if (q) {
    800031bc:	00078e63          	beqz	a5,800031d8 <_ZN15MemoryAllocator10kmem_allocEm+0x84>
            q->next = blockToAllocate->next;
    800031c0:	00053703          	ld	a4,0(a0)
    800031c4:	00e7b023          	sd	a4,0(a5)
            if (blockToAllocate->next) {
    800031c8:	00053703          	ld	a4,0(a0)
    800031cc:	04070c63          	beqz	a4,80003224 <_ZN15MemoryAllocator10kmem_allocEm+0xd0>
                blockToAllocate->next->prev = q;
    800031d0:	00f73423          	sd	a5,8(a4)
    800031d4:	0500006f          	j	80003224 <_ZN15MemoryAllocator10kmem_allocEm+0xd0>
            }
        }
        else{
            head = blockToAllocate->next;
    800031d8:	00053783          	ld	a5,0(a0)
    800031dc:	00004717          	auipc	a4,0x4
    800031e0:	2ef73223          	sd	a5,740(a4) # 800074c0 <_ZN15MemoryAllocator4headE>
            if(head)
    800031e4:	04078063          	beqz	a5,80003224 <_ZN15MemoryAllocator10kmem_allocEm+0xd0>
                blockToAllocate->next->prev = nullptr;
    800031e8:	0007b423          	sd	zero,8(a5)
    800031ec:	0380006f          	j	80003224 <_ZN15MemoryAllocator10kmem_allocEm+0xd0>
        }
    }
    else {
        Elem* newBlock = (Elem*)((char*)blockToAllocate + numOfBlocks * MEM_BLOCK_SIZE);
    800031f0:	00669793          	slli	a5,a3,0x6
    800031f4:	00f507b3          	add	a5,a0,a5
        newBlock->prev = blockToAllocate->prev;
    800031f8:	00853603          	ld	a2,8(a0)
    800031fc:	00c7b423          	sd	a2,8(a5)
        newBlock->next = blockToAllocate->next;
    80003200:	00053603          	ld	a2,0(a0)
    80003204:	00c7b023          	sd	a2,0(a5)
        if (blockToAllocate->prev)
    80003208:	00853603          	ld	a2,8(a0)
    8000320c:	02060663          	beqz	a2,80003238 <_ZN15MemoryAllocator10kmem_allocEm+0xe4>
            blockToAllocate->prev->next = newBlock;
    80003210:	00f63023          	sd	a5,0(a2)
        else
            head = newBlock;
        if (blockToAllocate->next)
    80003214:	00053603          	ld	a2,0(a0)
    80003218:	00060463          	beqz	a2,80003220 <_ZN15MemoryAllocator10kmem_allocEm+0xcc>
            blockToAllocate->next->prev = newBlock;
    8000321c:	00f63423          	sd	a5,8(a2)
        newBlock->numbersOfBlocks = remaining;
    80003220:	00e7b823          	sd	a4,16(a5)
    }
    //blockToAllocate->next = blockToAllocate->prev = nullptr;
    size_t* blocks = (size_t*)(blockToAllocate);
    *blocks = numOfBlocks;
    80003224:	00d53023          	sd	a3,0(a0)
    return (char*)blockToAllocate + sizeof(size_t);
    80003228:	00850513          	addi	a0,a0,8
}
    8000322c:	00813403          	ld	s0,8(sp)
    80003230:	01010113          	addi	sp,sp,16
    80003234:	00008067          	ret
            head = newBlock;
    80003238:	00004617          	auipc	a2,0x4
    8000323c:	28f63423          	sd	a5,648(a2) # 800074c0 <_ZN15MemoryAllocator4headE>
    80003240:	fd5ff06f          	j	80003214 <_ZN15MemoryAllocator10kmem_allocEm+0xc0>

0000000080003244 <_ZN15MemoryAllocator9kmem_freeEPv>:

int MemoryAllocator::kmem_free(void* addr) {
    80003244:	ff010113          	addi	sp,sp,-16
    80003248:	00813423          	sd	s0,8(sp)
    8000324c:	01010413          	addi	s0,sp,16
    size_t allocatedPartSize = *(size_t*)((char*)addr - sizeof(size_t));
    80003250:	ff853583          	ld	a1,-8(a0)
    char* allocatedPart = (char*)addr - sizeof(size_t); //allocated_part ukazuje na pocetak bloka, dok smo velicinu alociranog dela u blokovima sacuvali u prethodnom redu
    80003254:	ff850693          	addi	a3,a0,-8

    //pronalazimo cvor koji se nalazi neposredno pre nase adresu koju zelimo osloboditi
    Elem* curr = nullptr;
    if (!head || allocatedPart < (char*)head) {} //ukoliko je lista slobodnih clanova prazna ili je adresa alociranog dela pre glave liste slobodnih blokova
    80003258:	00004617          	auipc	a2,0x4
    8000325c:	26863603          	ld	a2,616(a2) # 800074c0 <_ZN15MemoryAllocator4headE>
    80003260:	06060463          	beqz	a2,800032c8 <_ZN15MemoryAllocator9kmem_freeEPv+0x84>
    80003264:	06c6e663          	bltu	a3,a2,800032d0 <_ZN15MemoryAllocator9kmem_freeEPv+0x8c>
    else {
        for (curr = head; curr->next != nullptr && allocatedPart > (char*)curr->next; curr = curr->next);
    80003268:	00060793          	mv	a5,a2
    8000326c:	00078713          	mv	a4,a5
    80003270:	0007b783          	ld	a5,0(a5)
    80003274:	00078463          	beqz	a5,8000327c <_ZN15MemoryAllocator9kmem_freeEPv+0x38>
    80003278:	fed7eae3          	bltu	a5,a3,8000326c <_ZN15MemoryAllocator9kmem_freeEPv+0x28>
    }

    //pokusaj spajanja sa prethodnim slobodnim segmentom
    if (curr && (char*)curr + curr->numbersOfBlocks * MEM_BLOCK_SIZE == allocatedPart) {
    8000327c:	04070c63          	beqz	a4,800032d4 <_ZN15MemoryAllocator9kmem_freeEPv+0x90>
    80003280:	01073883          	ld	a7,16(a4)
    80003284:	00689813          	slli	a6,a7,0x6
    80003288:	01070833          	add	a6,a4,a6
    8000328c:	04d81463          	bne	a6,a3,800032d4 <_ZN15MemoryAllocator9kmem_freeEPv+0x90>
        curr->numbersOfBlocks += allocatedPartSize;
    80003290:	00b885b3          	add	a1,a7,a1
    80003294:	00b73823          	sd	a1,16(a4)
        if (curr->next && (char*)curr + curr->numbersOfBlocks * MEM_BLOCK_SIZE == (char*)curr->next) {
    80003298:	06078e63          	beqz	a5,80003314 <_ZN15MemoryAllocator9kmem_freeEPv+0xd0>
    8000329c:	00659693          	slli	a3,a1,0x6
    800032a0:	00d706b3          	add	a3,a4,a3
    800032a4:	06d79863          	bne	a5,a3,80003314 <_ZN15MemoryAllocator9kmem_freeEPv+0xd0>
            curr->numbersOfBlocks += curr->next->numbersOfBlocks;
    800032a8:	0107b683          	ld	a3,16(a5)
    800032ac:	00d585b3          	add	a1,a1,a3
    800032b0:	00b73823          	sd	a1,16(a4)
            curr->next = curr->next->next;
    800032b4:	0007b783          	ld	a5,0(a5)
    800032b8:	00f73023          	sd	a5,0(a4)
            if (curr->next) curr->next->prev = curr;
    800032bc:	04078c63          	beqz	a5,80003314 <_ZN15MemoryAllocator9kmem_freeEPv+0xd0>
    800032c0:	00e7b423          	sd	a4,8(a5)
        }
        return 0;
    800032c4:	0500006f          	j	80003314 <_ZN15MemoryAllocator9kmem_freeEPv+0xd0>
    Elem* curr = nullptr;
    800032c8:	00060713          	mv	a4,a2
    800032cc:	0080006f          	j	800032d4 <_ZN15MemoryAllocator9kmem_freeEPv+0x90>
    800032d0:	00000713          	li	a4,0
    }

    //pokusaj spajanja sa narednim blokom
    Elem* nextBlock = curr ? curr->next : head;
    800032d4:	00070463          	beqz	a4,800032dc <_ZN15MemoryAllocator9kmem_freeEPv+0x98>
    800032d8:	00073603          	ld	a2,0(a4)
    if (nextBlock && allocatedPart + allocatedPartSize * MEM_BLOCK_SIZE == (char*)nextBlock) {
    800032dc:	00060863          	beqz	a2,800032ec <_ZN15MemoryAllocator9kmem_freeEPv+0xa8>
    800032e0:	00659793          	slli	a5,a1,0x6
    800032e4:	00f687b3          	add	a5,a3,a5
    800032e8:	02c78e63          	beq	a5,a2,80003324 <_ZN15MemoryAllocator9kmem_freeEPv+0xe0>
        return 0;
    }

    // nema mogucnosti za spajanje, ulancavamo samo slobodan fragment sa curr i njegovim sledbenikom ako postoje
    Elem* newBlock =(Elem*)allocatedPart;
    newBlock->numbersOfBlocks = allocatedPartSize;
    800032ec:	00b53423          	sd	a1,8(a0)
    newBlock->prev = curr;
    800032f0:	00e53023          	sd	a4,0(a0)
    if (curr) newBlock->next = curr->next;
    800032f4:	06070863          	beqz	a4,80003364 <_ZN15MemoryAllocator9kmem_freeEPv+0x120>
    800032f8:	00073783          	ld	a5,0(a4)
    800032fc:	fef53c23          	sd	a5,-8(a0)
    else newBlock->next = head;
    if (newBlock->next) newBlock->next->prev = newBlock;
    80003300:	ff853783          	ld	a5,-8(a0)
    80003304:	00078463          	beqz	a5,8000330c <_ZN15MemoryAllocator9kmem_freeEPv+0xc8>
    80003308:	00d7b423          	sd	a3,8(a5)
    if (curr) curr->next = newBlock;
    8000330c:	06070463          	beqz	a4,80003374 <_ZN15MemoryAllocator9kmem_freeEPv+0x130>
    80003310:	00d73023          	sd	a3,0(a4)
    else head = newBlock;
    return 0;
    80003314:	00000513          	li	a0,0
    80003318:	00813403          	ld	s0,8(sp)
    8000331c:	01010113          	addi	sp,sp,16
    80003320:	00008067          	ret
        newBlock->numbersOfBlocks = nextBlock->numbersOfBlocks + allocatedPartSize;
    80003324:	01063783          	ld	a5,16(a2)
    80003328:	00b785b3          	add	a1,a5,a1
    8000332c:	00b53423          	sd	a1,8(a0)
        newBlock->prev = nextBlock->prev;
    80003330:	00863783          	ld	a5,8(a2)
    80003334:	00f53023          	sd	a5,0(a0)
        newBlock->next = nextBlock->next;
    80003338:	00063783          	ld	a5,0(a2)
    8000333c:	fef53c23          	sd	a5,-8(a0)
        if (nextBlock->next) nextBlock->next->prev = newBlock;
    80003340:	00078463          	beqz	a5,80003348 <_ZN15MemoryAllocator9kmem_freeEPv+0x104>
    80003344:	00d7b423          	sd	a3,8(a5)
        if (nextBlock->prev) nextBlock->prev->next = newBlock;
    80003348:	00863783          	ld	a5,8(a2)
    8000334c:	00078663          	beqz	a5,80003358 <_ZN15MemoryAllocator9kmem_freeEPv+0x114>
    80003350:	00d7b023          	sd	a3,0(a5)
    80003354:	fc1ff06f          	j	80003314 <_ZN15MemoryAllocator9kmem_freeEPv+0xd0>
        else head = newBlock;
    80003358:	00004797          	auipc	a5,0x4
    8000335c:	16d7b423          	sd	a3,360(a5) # 800074c0 <_ZN15MemoryAllocator4headE>
        return 0;
    80003360:	fb5ff06f          	j	80003314 <_ZN15MemoryAllocator9kmem_freeEPv+0xd0>
    else newBlock->next = head;
    80003364:	00004797          	auipc	a5,0x4
    80003368:	15c7b783          	ld	a5,348(a5) # 800074c0 <_ZN15MemoryAllocator4headE>
    8000336c:	fef53c23          	sd	a5,-8(a0)
    80003370:	f91ff06f          	j	80003300 <_ZN15MemoryAllocator9kmem_freeEPv+0xbc>
    else head = newBlock;
    80003374:	00004797          	auipc	a5,0x4
    80003378:	14d7b623          	sd	a3,332(a5) # 800074c0 <_ZN15MemoryAllocator4headE>
    8000337c:	f99ff06f          	j	80003314 <_ZN15MemoryAllocator9kmem_freeEPv+0xd0>

0000000080003380 <start>:
    80003380:	ff010113          	addi	sp,sp,-16
    80003384:	00813423          	sd	s0,8(sp)
    80003388:	01010413          	addi	s0,sp,16
    8000338c:	300027f3          	csrr	a5,mstatus
    80003390:	ffffe737          	lui	a4,0xffffe
    80003394:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff60cf>
    80003398:	00e7f7b3          	and	a5,a5,a4
    8000339c:	00001737          	lui	a4,0x1
    800033a0:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    800033a4:	00e7e7b3          	or	a5,a5,a4
    800033a8:	30079073          	csrw	mstatus,a5
    800033ac:	00000797          	auipc	a5,0x0
    800033b0:	16078793          	addi	a5,a5,352 # 8000350c <system_main>
    800033b4:	34179073          	csrw	mepc,a5
    800033b8:	00000793          	li	a5,0
    800033bc:	18079073          	csrw	satp,a5
    800033c0:	000107b7          	lui	a5,0x10
    800033c4:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    800033c8:	30279073          	csrw	medeleg,a5
    800033cc:	30379073          	csrw	mideleg,a5
    800033d0:	104027f3          	csrr	a5,sie
    800033d4:	2227e793          	ori	a5,a5,546
    800033d8:	10479073          	csrw	sie,a5
    800033dc:	fff00793          	li	a5,-1
    800033e0:	00a7d793          	srli	a5,a5,0xa
    800033e4:	3b079073          	csrw	pmpaddr0,a5
    800033e8:	00f00793          	li	a5,15
    800033ec:	3a079073          	csrw	pmpcfg0,a5
    800033f0:	f14027f3          	csrr	a5,mhartid
    800033f4:	0200c737          	lui	a4,0x200c
    800033f8:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    800033fc:	0007869b          	sext.w	a3,a5
    80003400:	00269713          	slli	a4,a3,0x2
    80003404:	000f4637          	lui	a2,0xf4
    80003408:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    8000340c:	00d70733          	add	a4,a4,a3
    80003410:	0037979b          	slliw	a5,a5,0x3
    80003414:	020046b7          	lui	a3,0x2004
    80003418:	00d787b3          	add	a5,a5,a3
    8000341c:	00c585b3          	add	a1,a1,a2
    80003420:	00371693          	slli	a3,a4,0x3
    80003424:	00004717          	auipc	a4,0x4
    80003428:	0ac70713          	addi	a4,a4,172 # 800074d0 <timer_scratch>
    8000342c:	00b7b023          	sd	a1,0(a5)
    80003430:	00d70733          	add	a4,a4,a3
    80003434:	00f73c23          	sd	a5,24(a4)
    80003438:	02c73023          	sd	a2,32(a4)
    8000343c:	34071073          	csrw	mscratch,a4
    80003440:	00000797          	auipc	a5,0x0
    80003444:	6e078793          	addi	a5,a5,1760 # 80003b20 <timervec>
    80003448:	30579073          	csrw	mtvec,a5
    8000344c:	300027f3          	csrr	a5,mstatus
    80003450:	0087e793          	ori	a5,a5,8
    80003454:	30079073          	csrw	mstatus,a5
    80003458:	304027f3          	csrr	a5,mie
    8000345c:	0807e793          	ori	a5,a5,128
    80003460:	30479073          	csrw	mie,a5
    80003464:	f14027f3          	csrr	a5,mhartid
    80003468:	0007879b          	sext.w	a5,a5
    8000346c:	00078213          	mv	tp,a5
    80003470:	30200073          	mret
    80003474:	00813403          	ld	s0,8(sp)
    80003478:	01010113          	addi	sp,sp,16
    8000347c:	00008067          	ret

0000000080003480 <timerinit>:
    80003480:	ff010113          	addi	sp,sp,-16
    80003484:	00813423          	sd	s0,8(sp)
    80003488:	01010413          	addi	s0,sp,16
    8000348c:	f14027f3          	csrr	a5,mhartid
    80003490:	0200c737          	lui	a4,0x200c
    80003494:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80003498:	0007869b          	sext.w	a3,a5
    8000349c:	00269713          	slli	a4,a3,0x2
    800034a0:	000f4637          	lui	a2,0xf4
    800034a4:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    800034a8:	00d70733          	add	a4,a4,a3
    800034ac:	0037979b          	slliw	a5,a5,0x3
    800034b0:	020046b7          	lui	a3,0x2004
    800034b4:	00d787b3          	add	a5,a5,a3
    800034b8:	00c585b3          	add	a1,a1,a2
    800034bc:	00371693          	slli	a3,a4,0x3
    800034c0:	00004717          	auipc	a4,0x4
    800034c4:	01070713          	addi	a4,a4,16 # 800074d0 <timer_scratch>
    800034c8:	00b7b023          	sd	a1,0(a5)
    800034cc:	00d70733          	add	a4,a4,a3
    800034d0:	00f73c23          	sd	a5,24(a4)
    800034d4:	02c73023          	sd	a2,32(a4)
    800034d8:	34071073          	csrw	mscratch,a4
    800034dc:	00000797          	auipc	a5,0x0
    800034e0:	64478793          	addi	a5,a5,1604 # 80003b20 <timervec>
    800034e4:	30579073          	csrw	mtvec,a5
    800034e8:	300027f3          	csrr	a5,mstatus
    800034ec:	0087e793          	ori	a5,a5,8
    800034f0:	30079073          	csrw	mstatus,a5
    800034f4:	304027f3          	csrr	a5,mie
    800034f8:	0807e793          	ori	a5,a5,128
    800034fc:	30479073          	csrw	mie,a5
    80003500:	00813403          	ld	s0,8(sp)
    80003504:	01010113          	addi	sp,sp,16
    80003508:	00008067          	ret

000000008000350c <system_main>:
    8000350c:	fe010113          	addi	sp,sp,-32
    80003510:	00813823          	sd	s0,16(sp)
    80003514:	00913423          	sd	s1,8(sp)
    80003518:	00113c23          	sd	ra,24(sp)
    8000351c:	02010413          	addi	s0,sp,32
    80003520:	00000097          	auipc	ra,0x0
    80003524:	0c4080e7          	jalr	196(ra) # 800035e4 <cpuid>
    80003528:	00004497          	auipc	s1,0x4
    8000352c:	f0848493          	addi	s1,s1,-248 # 80007430 <started>
    80003530:	02050263          	beqz	a0,80003554 <system_main+0x48>
    80003534:	0004a783          	lw	a5,0(s1)
    80003538:	0007879b          	sext.w	a5,a5
    8000353c:	fe078ce3          	beqz	a5,80003534 <system_main+0x28>
    80003540:	0ff0000f          	fence
    80003544:	00003517          	auipc	a0,0x3
    80003548:	c5450513          	addi	a0,a0,-940 # 80006198 <CONSOLE_STATUS+0x188>
    8000354c:	00001097          	auipc	ra,0x1
    80003550:	a70080e7          	jalr	-1424(ra) # 80003fbc <panic>
    80003554:	00001097          	auipc	ra,0x1
    80003558:	9c4080e7          	jalr	-1596(ra) # 80003f18 <consoleinit>
    8000355c:	00001097          	auipc	ra,0x1
    80003560:	150080e7          	jalr	336(ra) # 800046ac <printfinit>
    80003564:	00003517          	auipc	a0,0x3
    80003568:	d1450513          	addi	a0,a0,-748 # 80006278 <CONSOLE_STATUS+0x268>
    8000356c:	00001097          	auipc	ra,0x1
    80003570:	aac080e7          	jalr	-1364(ra) # 80004018 <__printf>
    80003574:	00003517          	auipc	a0,0x3
    80003578:	bf450513          	addi	a0,a0,-1036 # 80006168 <CONSOLE_STATUS+0x158>
    8000357c:	00001097          	auipc	ra,0x1
    80003580:	a9c080e7          	jalr	-1380(ra) # 80004018 <__printf>
    80003584:	00003517          	auipc	a0,0x3
    80003588:	cf450513          	addi	a0,a0,-780 # 80006278 <CONSOLE_STATUS+0x268>
    8000358c:	00001097          	auipc	ra,0x1
    80003590:	a8c080e7          	jalr	-1396(ra) # 80004018 <__printf>
    80003594:	00001097          	auipc	ra,0x1
    80003598:	4a4080e7          	jalr	1188(ra) # 80004a38 <kinit>
    8000359c:	00000097          	auipc	ra,0x0
    800035a0:	148080e7          	jalr	328(ra) # 800036e4 <trapinit>
    800035a4:	00000097          	auipc	ra,0x0
    800035a8:	16c080e7          	jalr	364(ra) # 80003710 <trapinithart>
    800035ac:	00000097          	auipc	ra,0x0
    800035b0:	5b4080e7          	jalr	1460(ra) # 80003b60 <plicinit>
    800035b4:	00000097          	auipc	ra,0x0
    800035b8:	5d4080e7          	jalr	1492(ra) # 80003b88 <plicinithart>
    800035bc:	00000097          	auipc	ra,0x0
    800035c0:	078080e7          	jalr	120(ra) # 80003634 <userinit>
    800035c4:	0ff0000f          	fence
    800035c8:	00100793          	li	a5,1
    800035cc:	00003517          	auipc	a0,0x3
    800035d0:	bb450513          	addi	a0,a0,-1100 # 80006180 <CONSOLE_STATUS+0x170>
    800035d4:	00f4a023          	sw	a5,0(s1)
    800035d8:	00001097          	auipc	ra,0x1
    800035dc:	a40080e7          	jalr	-1472(ra) # 80004018 <__printf>
    800035e0:	0000006f          	j	800035e0 <system_main+0xd4>

00000000800035e4 <cpuid>:
    800035e4:	ff010113          	addi	sp,sp,-16
    800035e8:	00813423          	sd	s0,8(sp)
    800035ec:	01010413          	addi	s0,sp,16
    800035f0:	00020513          	mv	a0,tp
    800035f4:	00813403          	ld	s0,8(sp)
    800035f8:	0005051b          	sext.w	a0,a0
    800035fc:	01010113          	addi	sp,sp,16
    80003600:	00008067          	ret

0000000080003604 <mycpu>:
    80003604:	ff010113          	addi	sp,sp,-16
    80003608:	00813423          	sd	s0,8(sp)
    8000360c:	01010413          	addi	s0,sp,16
    80003610:	00020793          	mv	a5,tp
    80003614:	00813403          	ld	s0,8(sp)
    80003618:	0007879b          	sext.w	a5,a5
    8000361c:	00779793          	slli	a5,a5,0x7
    80003620:	00005517          	auipc	a0,0x5
    80003624:	ee050513          	addi	a0,a0,-288 # 80008500 <cpus>
    80003628:	00f50533          	add	a0,a0,a5
    8000362c:	01010113          	addi	sp,sp,16
    80003630:	00008067          	ret

0000000080003634 <userinit>:
    80003634:	ff010113          	addi	sp,sp,-16
    80003638:	00813423          	sd	s0,8(sp)
    8000363c:	01010413          	addi	s0,sp,16
    80003640:	00813403          	ld	s0,8(sp)
    80003644:	01010113          	addi	sp,sp,16
    80003648:	fffff317          	auipc	t1,0xfffff
    8000364c:	fe030067          	jr	-32(t1) # 80002628 <main>

0000000080003650 <either_copyout>:
    80003650:	ff010113          	addi	sp,sp,-16
    80003654:	00813023          	sd	s0,0(sp)
    80003658:	00113423          	sd	ra,8(sp)
    8000365c:	01010413          	addi	s0,sp,16
    80003660:	02051663          	bnez	a0,8000368c <either_copyout+0x3c>
    80003664:	00058513          	mv	a0,a1
    80003668:	00060593          	mv	a1,a2
    8000366c:	0006861b          	sext.w	a2,a3
    80003670:	00002097          	auipc	ra,0x2
    80003674:	c54080e7          	jalr	-940(ra) # 800052c4 <__memmove>
    80003678:	00813083          	ld	ra,8(sp)
    8000367c:	00013403          	ld	s0,0(sp)
    80003680:	00000513          	li	a0,0
    80003684:	01010113          	addi	sp,sp,16
    80003688:	00008067          	ret
    8000368c:	00003517          	auipc	a0,0x3
    80003690:	b3450513          	addi	a0,a0,-1228 # 800061c0 <CONSOLE_STATUS+0x1b0>
    80003694:	00001097          	auipc	ra,0x1
    80003698:	928080e7          	jalr	-1752(ra) # 80003fbc <panic>

000000008000369c <either_copyin>:
    8000369c:	ff010113          	addi	sp,sp,-16
    800036a0:	00813023          	sd	s0,0(sp)
    800036a4:	00113423          	sd	ra,8(sp)
    800036a8:	01010413          	addi	s0,sp,16
    800036ac:	02059463          	bnez	a1,800036d4 <either_copyin+0x38>
    800036b0:	00060593          	mv	a1,a2
    800036b4:	0006861b          	sext.w	a2,a3
    800036b8:	00002097          	auipc	ra,0x2
    800036bc:	c0c080e7          	jalr	-1012(ra) # 800052c4 <__memmove>
    800036c0:	00813083          	ld	ra,8(sp)
    800036c4:	00013403          	ld	s0,0(sp)
    800036c8:	00000513          	li	a0,0
    800036cc:	01010113          	addi	sp,sp,16
    800036d0:	00008067          	ret
    800036d4:	00003517          	auipc	a0,0x3
    800036d8:	b1450513          	addi	a0,a0,-1260 # 800061e8 <CONSOLE_STATUS+0x1d8>
    800036dc:	00001097          	auipc	ra,0x1
    800036e0:	8e0080e7          	jalr	-1824(ra) # 80003fbc <panic>

00000000800036e4 <trapinit>:
    800036e4:	ff010113          	addi	sp,sp,-16
    800036e8:	00813423          	sd	s0,8(sp)
    800036ec:	01010413          	addi	s0,sp,16
    800036f0:	00813403          	ld	s0,8(sp)
    800036f4:	00003597          	auipc	a1,0x3
    800036f8:	b1c58593          	addi	a1,a1,-1252 # 80006210 <CONSOLE_STATUS+0x200>
    800036fc:	00005517          	auipc	a0,0x5
    80003700:	e8450513          	addi	a0,a0,-380 # 80008580 <tickslock>
    80003704:	01010113          	addi	sp,sp,16
    80003708:	00001317          	auipc	t1,0x1
    8000370c:	5c030067          	jr	1472(t1) # 80004cc8 <initlock>

0000000080003710 <trapinithart>:
    80003710:	ff010113          	addi	sp,sp,-16
    80003714:	00813423          	sd	s0,8(sp)
    80003718:	01010413          	addi	s0,sp,16
    8000371c:	00000797          	auipc	a5,0x0
    80003720:	2f478793          	addi	a5,a5,756 # 80003a10 <kernelvec>
    80003724:	10579073          	csrw	stvec,a5
    80003728:	00813403          	ld	s0,8(sp)
    8000372c:	01010113          	addi	sp,sp,16
    80003730:	00008067          	ret

0000000080003734 <usertrap>:
    80003734:	ff010113          	addi	sp,sp,-16
    80003738:	00813423          	sd	s0,8(sp)
    8000373c:	01010413          	addi	s0,sp,16
    80003740:	00813403          	ld	s0,8(sp)
    80003744:	01010113          	addi	sp,sp,16
    80003748:	00008067          	ret

000000008000374c <usertrapret>:
    8000374c:	ff010113          	addi	sp,sp,-16
    80003750:	00813423          	sd	s0,8(sp)
    80003754:	01010413          	addi	s0,sp,16
    80003758:	00813403          	ld	s0,8(sp)
    8000375c:	01010113          	addi	sp,sp,16
    80003760:	00008067          	ret

0000000080003764 <kerneltrap>:
    80003764:	fe010113          	addi	sp,sp,-32
    80003768:	00813823          	sd	s0,16(sp)
    8000376c:	00113c23          	sd	ra,24(sp)
    80003770:	00913423          	sd	s1,8(sp)
    80003774:	02010413          	addi	s0,sp,32
    80003778:	142025f3          	csrr	a1,scause
    8000377c:	100027f3          	csrr	a5,sstatus
    80003780:	0027f793          	andi	a5,a5,2
    80003784:	10079c63          	bnez	a5,8000389c <kerneltrap+0x138>
    80003788:	142027f3          	csrr	a5,scause
    8000378c:	0207ce63          	bltz	a5,800037c8 <kerneltrap+0x64>
    80003790:	00003517          	auipc	a0,0x3
    80003794:	ac850513          	addi	a0,a0,-1336 # 80006258 <CONSOLE_STATUS+0x248>
    80003798:	00001097          	auipc	ra,0x1
    8000379c:	880080e7          	jalr	-1920(ra) # 80004018 <__printf>
    800037a0:	141025f3          	csrr	a1,sepc
    800037a4:	14302673          	csrr	a2,stval
    800037a8:	00003517          	auipc	a0,0x3
    800037ac:	ac050513          	addi	a0,a0,-1344 # 80006268 <CONSOLE_STATUS+0x258>
    800037b0:	00001097          	auipc	ra,0x1
    800037b4:	868080e7          	jalr	-1944(ra) # 80004018 <__printf>
    800037b8:	00003517          	auipc	a0,0x3
    800037bc:	ac850513          	addi	a0,a0,-1336 # 80006280 <CONSOLE_STATUS+0x270>
    800037c0:	00000097          	auipc	ra,0x0
    800037c4:	7fc080e7          	jalr	2044(ra) # 80003fbc <panic>
    800037c8:	0ff7f713          	andi	a4,a5,255
    800037cc:	00900693          	li	a3,9
    800037d0:	04d70063          	beq	a4,a3,80003810 <kerneltrap+0xac>
    800037d4:	fff00713          	li	a4,-1
    800037d8:	03f71713          	slli	a4,a4,0x3f
    800037dc:	00170713          	addi	a4,a4,1
    800037e0:	fae798e3          	bne	a5,a4,80003790 <kerneltrap+0x2c>
    800037e4:	00000097          	auipc	ra,0x0
    800037e8:	e00080e7          	jalr	-512(ra) # 800035e4 <cpuid>
    800037ec:	06050663          	beqz	a0,80003858 <kerneltrap+0xf4>
    800037f0:	144027f3          	csrr	a5,sip
    800037f4:	ffd7f793          	andi	a5,a5,-3
    800037f8:	14479073          	csrw	sip,a5
    800037fc:	01813083          	ld	ra,24(sp)
    80003800:	01013403          	ld	s0,16(sp)
    80003804:	00813483          	ld	s1,8(sp)
    80003808:	02010113          	addi	sp,sp,32
    8000380c:	00008067          	ret
    80003810:	00000097          	auipc	ra,0x0
    80003814:	3c4080e7          	jalr	964(ra) # 80003bd4 <plic_claim>
    80003818:	00a00793          	li	a5,10
    8000381c:	00050493          	mv	s1,a0
    80003820:	06f50863          	beq	a0,a5,80003890 <kerneltrap+0x12c>
    80003824:	fc050ce3          	beqz	a0,800037fc <kerneltrap+0x98>
    80003828:	00050593          	mv	a1,a0
    8000382c:	00003517          	auipc	a0,0x3
    80003830:	a0c50513          	addi	a0,a0,-1524 # 80006238 <CONSOLE_STATUS+0x228>
    80003834:	00000097          	auipc	ra,0x0
    80003838:	7e4080e7          	jalr	2020(ra) # 80004018 <__printf>
    8000383c:	01013403          	ld	s0,16(sp)
    80003840:	01813083          	ld	ra,24(sp)
    80003844:	00048513          	mv	a0,s1
    80003848:	00813483          	ld	s1,8(sp)
    8000384c:	02010113          	addi	sp,sp,32
    80003850:	00000317          	auipc	t1,0x0
    80003854:	3bc30067          	jr	956(t1) # 80003c0c <plic_complete>
    80003858:	00005517          	auipc	a0,0x5
    8000385c:	d2850513          	addi	a0,a0,-728 # 80008580 <tickslock>
    80003860:	00001097          	auipc	ra,0x1
    80003864:	48c080e7          	jalr	1164(ra) # 80004cec <acquire>
    80003868:	00004717          	auipc	a4,0x4
    8000386c:	bcc70713          	addi	a4,a4,-1076 # 80007434 <ticks>
    80003870:	00072783          	lw	a5,0(a4)
    80003874:	00005517          	auipc	a0,0x5
    80003878:	d0c50513          	addi	a0,a0,-756 # 80008580 <tickslock>
    8000387c:	0017879b          	addiw	a5,a5,1
    80003880:	00f72023          	sw	a5,0(a4)
    80003884:	00001097          	auipc	ra,0x1
    80003888:	534080e7          	jalr	1332(ra) # 80004db8 <release>
    8000388c:	f65ff06f          	j	800037f0 <kerneltrap+0x8c>
    80003890:	00001097          	auipc	ra,0x1
    80003894:	090080e7          	jalr	144(ra) # 80004920 <uartintr>
    80003898:	fa5ff06f          	j	8000383c <kerneltrap+0xd8>
    8000389c:	00003517          	auipc	a0,0x3
    800038a0:	97c50513          	addi	a0,a0,-1668 # 80006218 <CONSOLE_STATUS+0x208>
    800038a4:	00000097          	auipc	ra,0x0
    800038a8:	718080e7          	jalr	1816(ra) # 80003fbc <panic>

00000000800038ac <clockintr>:
    800038ac:	fe010113          	addi	sp,sp,-32
    800038b0:	00813823          	sd	s0,16(sp)
    800038b4:	00913423          	sd	s1,8(sp)
    800038b8:	00113c23          	sd	ra,24(sp)
    800038bc:	02010413          	addi	s0,sp,32
    800038c0:	00005497          	auipc	s1,0x5
    800038c4:	cc048493          	addi	s1,s1,-832 # 80008580 <tickslock>
    800038c8:	00048513          	mv	a0,s1
    800038cc:	00001097          	auipc	ra,0x1
    800038d0:	420080e7          	jalr	1056(ra) # 80004cec <acquire>
    800038d4:	00004717          	auipc	a4,0x4
    800038d8:	b6070713          	addi	a4,a4,-1184 # 80007434 <ticks>
    800038dc:	00072783          	lw	a5,0(a4)
    800038e0:	01013403          	ld	s0,16(sp)
    800038e4:	01813083          	ld	ra,24(sp)
    800038e8:	00048513          	mv	a0,s1
    800038ec:	0017879b          	addiw	a5,a5,1
    800038f0:	00813483          	ld	s1,8(sp)
    800038f4:	00f72023          	sw	a5,0(a4)
    800038f8:	02010113          	addi	sp,sp,32
    800038fc:	00001317          	auipc	t1,0x1
    80003900:	4bc30067          	jr	1212(t1) # 80004db8 <release>

0000000080003904 <devintr>:
    80003904:	142027f3          	csrr	a5,scause
    80003908:	00000513          	li	a0,0
    8000390c:	0007c463          	bltz	a5,80003914 <devintr+0x10>
    80003910:	00008067          	ret
    80003914:	fe010113          	addi	sp,sp,-32
    80003918:	00813823          	sd	s0,16(sp)
    8000391c:	00113c23          	sd	ra,24(sp)
    80003920:	00913423          	sd	s1,8(sp)
    80003924:	02010413          	addi	s0,sp,32
    80003928:	0ff7f713          	andi	a4,a5,255
    8000392c:	00900693          	li	a3,9
    80003930:	04d70c63          	beq	a4,a3,80003988 <devintr+0x84>
    80003934:	fff00713          	li	a4,-1
    80003938:	03f71713          	slli	a4,a4,0x3f
    8000393c:	00170713          	addi	a4,a4,1
    80003940:	00e78c63          	beq	a5,a4,80003958 <devintr+0x54>
    80003944:	01813083          	ld	ra,24(sp)
    80003948:	01013403          	ld	s0,16(sp)
    8000394c:	00813483          	ld	s1,8(sp)
    80003950:	02010113          	addi	sp,sp,32
    80003954:	00008067          	ret
    80003958:	00000097          	auipc	ra,0x0
    8000395c:	c8c080e7          	jalr	-884(ra) # 800035e4 <cpuid>
    80003960:	06050663          	beqz	a0,800039cc <devintr+0xc8>
    80003964:	144027f3          	csrr	a5,sip
    80003968:	ffd7f793          	andi	a5,a5,-3
    8000396c:	14479073          	csrw	sip,a5
    80003970:	01813083          	ld	ra,24(sp)
    80003974:	01013403          	ld	s0,16(sp)
    80003978:	00813483          	ld	s1,8(sp)
    8000397c:	00200513          	li	a0,2
    80003980:	02010113          	addi	sp,sp,32
    80003984:	00008067          	ret
    80003988:	00000097          	auipc	ra,0x0
    8000398c:	24c080e7          	jalr	588(ra) # 80003bd4 <plic_claim>
    80003990:	00a00793          	li	a5,10
    80003994:	00050493          	mv	s1,a0
    80003998:	06f50663          	beq	a0,a5,80003a04 <devintr+0x100>
    8000399c:	00100513          	li	a0,1
    800039a0:	fa0482e3          	beqz	s1,80003944 <devintr+0x40>
    800039a4:	00048593          	mv	a1,s1
    800039a8:	00003517          	auipc	a0,0x3
    800039ac:	89050513          	addi	a0,a0,-1904 # 80006238 <CONSOLE_STATUS+0x228>
    800039b0:	00000097          	auipc	ra,0x0
    800039b4:	668080e7          	jalr	1640(ra) # 80004018 <__printf>
    800039b8:	00048513          	mv	a0,s1
    800039bc:	00000097          	auipc	ra,0x0
    800039c0:	250080e7          	jalr	592(ra) # 80003c0c <plic_complete>
    800039c4:	00100513          	li	a0,1
    800039c8:	f7dff06f          	j	80003944 <devintr+0x40>
    800039cc:	00005517          	auipc	a0,0x5
    800039d0:	bb450513          	addi	a0,a0,-1100 # 80008580 <tickslock>
    800039d4:	00001097          	auipc	ra,0x1
    800039d8:	318080e7          	jalr	792(ra) # 80004cec <acquire>
    800039dc:	00004717          	auipc	a4,0x4
    800039e0:	a5870713          	addi	a4,a4,-1448 # 80007434 <ticks>
    800039e4:	00072783          	lw	a5,0(a4)
    800039e8:	00005517          	auipc	a0,0x5
    800039ec:	b9850513          	addi	a0,a0,-1128 # 80008580 <tickslock>
    800039f0:	0017879b          	addiw	a5,a5,1
    800039f4:	00f72023          	sw	a5,0(a4)
    800039f8:	00001097          	auipc	ra,0x1
    800039fc:	3c0080e7          	jalr	960(ra) # 80004db8 <release>
    80003a00:	f65ff06f          	j	80003964 <devintr+0x60>
    80003a04:	00001097          	auipc	ra,0x1
    80003a08:	f1c080e7          	jalr	-228(ra) # 80004920 <uartintr>
    80003a0c:	fadff06f          	j	800039b8 <devintr+0xb4>

0000000080003a10 <kernelvec>:
    80003a10:	f0010113          	addi	sp,sp,-256
    80003a14:	00113023          	sd	ra,0(sp)
    80003a18:	00213423          	sd	sp,8(sp)
    80003a1c:	00313823          	sd	gp,16(sp)
    80003a20:	00413c23          	sd	tp,24(sp)
    80003a24:	02513023          	sd	t0,32(sp)
    80003a28:	02613423          	sd	t1,40(sp)
    80003a2c:	02713823          	sd	t2,48(sp)
    80003a30:	02813c23          	sd	s0,56(sp)
    80003a34:	04913023          	sd	s1,64(sp)
    80003a38:	04a13423          	sd	a0,72(sp)
    80003a3c:	04b13823          	sd	a1,80(sp)
    80003a40:	04c13c23          	sd	a2,88(sp)
    80003a44:	06d13023          	sd	a3,96(sp)
    80003a48:	06e13423          	sd	a4,104(sp)
    80003a4c:	06f13823          	sd	a5,112(sp)
    80003a50:	07013c23          	sd	a6,120(sp)
    80003a54:	09113023          	sd	a7,128(sp)
    80003a58:	09213423          	sd	s2,136(sp)
    80003a5c:	09313823          	sd	s3,144(sp)
    80003a60:	09413c23          	sd	s4,152(sp)
    80003a64:	0b513023          	sd	s5,160(sp)
    80003a68:	0b613423          	sd	s6,168(sp)
    80003a6c:	0b713823          	sd	s7,176(sp)
    80003a70:	0b813c23          	sd	s8,184(sp)
    80003a74:	0d913023          	sd	s9,192(sp)
    80003a78:	0da13423          	sd	s10,200(sp)
    80003a7c:	0db13823          	sd	s11,208(sp)
    80003a80:	0dc13c23          	sd	t3,216(sp)
    80003a84:	0fd13023          	sd	t4,224(sp)
    80003a88:	0fe13423          	sd	t5,232(sp)
    80003a8c:	0ff13823          	sd	t6,240(sp)
    80003a90:	cd5ff0ef          	jal	ra,80003764 <kerneltrap>
    80003a94:	00013083          	ld	ra,0(sp)
    80003a98:	00813103          	ld	sp,8(sp)
    80003a9c:	01013183          	ld	gp,16(sp)
    80003aa0:	02013283          	ld	t0,32(sp)
    80003aa4:	02813303          	ld	t1,40(sp)
    80003aa8:	03013383          	ld	t2,48(sp)
    80003aac:	03813403          	ld	s0,56(sp)
    80003ab0:	04013483          	ld	s1,64(sp)
    80003ab4:	04813503          	ld	a0,72(sp)
    80003ab8:	05013583          	ld	a1,80(sp)
    80003abc:	05813603          	ld	a2,88(sp)
    80003ac0:	06013683          	ld	a3,96(sp)
    80003ac4:	06813703          	ld	a4,104(sp)
    80003ac8:	07013783          	ld	a5,112(sp)
    80003acc:	07813803          	ld	a6,120(sp)
    80003ad0:	08013883          	ld	a7,128(sp)
    80003ad4:	08813903          	ld	s2,136(sp)
    80003ad8:	09013983          	ld	s3,144(sp)
    80003adc:	09813a03          	ld	s4,152(sp)
    80003ae0:	0a013a83          	ld	s5,160(sp)
    80003ae4:	0a813b03          	ld	s6,168(sp)
    80003ae8:	0b013b83          	ld	s7,176(sp)
    80003aec:	0b813c03          	ld	s8,184(sp)
    80003af0:	0c013c83          	ld	s9,192(sp)
    80003af4:	0c813d03          	ld	s10,200(sp)
    80003af8:	0d013d83          	ld	s11,208(sp)
    80003afc:	0d813e03          	ld	t3,216(sp)
    80003b00:	0e013e83          	ld	t4,224(sp)
    80003b04:	0e813f03          	ld	t5,232(sp)
    80003b08:	0f013f83          	ld	t6,240(sp)
    80003b0c:	10010113          	addi	sp,sp,256
    80003b10:	10200073          	sret
    80003b14:	00000013          	nop
    80003b18:	00000013          	nop
    80003b1c:	00000013          	nop

0000000080003b20 <timervec>:
    80003b20:	34051573          	csrrw	a0,mscratch,a0
    80003b24:	00b53023          	sd	a1,0(a0)
    80003b28:	00c53423          	sd	a2,8(a0)
    80003b2c:	00d53823          	sd	a3,16(a0)
    80003b30:	01853583          	ld	a1,24(a0)
    80003b34:	02053603          	ld	a2,32(a0)
    80003b38:	0005b683          	ld	a3,0(a1)
    80003b3c:	00c686b3          	add	a3,a3,a2
    80003b40:	00d5b023          	sd	a3,0(a1)
    80003b44:	00200593          	li	a1,2
    80003b48:	14459073          	csrw	sip,a1
    80003b4c:	01053683          	ld	a3,16(a0)
    80003b50:	00853603          	ld	a2,8(a0)
    80003b54:	00053583          	ld	a1,0(a0)
    80003b58:	34051573          	csrrw	a0,mscratch,a0
    80003b5c:	30200073          	mret

0000000080003b60 <plicinit>:
    80003b60:	ff010113          	addi	sp,sp,-16
    80003b64:	00813423          	sd	s0,8(sp)
    80003b68:	01010413          	addi	s0,sp,16
    80003b6c:	00813403          	ld	s0,8(sp)
    80003b70:	0c0007b7          	lui	a5,0xc000
    80003b74:	00100713          	li	a4,1
    80003b78:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    80003b7c:	00e7a223          	sw	a4,4(a5)
    80003b80:	01010113          	addi	sp,sp,16
    80003b84:	00008067          	ret

0000000080003b88 <plicinithart>:
    80003b88:	ff010113          	addi	sp,sp,-16
    80003b8c:	00813023          	sd	s0,0(sp)
    80003b90:	00113423          	sd	ra,8(sp)
    80003b94:	01010413          	addi	s0,sp,16
    80003b98:	00000097          	auipc	ra,0x0
    80003b9c:	a4c080e7          	jalr	-1460(ra) # 800035e4 <cpuid>
    80003ba0:	0085171b          	slliw	a4,a0,0x8
    80003ba4:	0c0027b7          	lui	a5,0xc002
    80003ba8:	00e787b3          	add	a5,a5,a4
    80003bac:	40200713          	li	a4,1026
    80003bb0:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80003bb4:	00813083          	ld	ra,8(sp)
    80003bb8:	00013403          	ld	s0,0(sp)
    80003bbc:	00d5151b          	slliw	a0,a0,0xd
    80003bc0:	0c2017b7          	lui	a5,0xc201
    80003bc4:	00a78533          	add	a0,a5,a0
    80003bc8:	00052023          	sw	zero,0(a0)
    80003bcc:	01010113          	addi	sp,sp,16
    80003bd0:	00008067          	ret

0000000080003bd4 <plic_claim>:
    80003bd4:	ff010113          	addi	sp,sp,-16
    80003bd8:	00813023          	sd	s0,0(sp)
    80003bdc:	00113423          	sd	ra,8(sp)
    80003be0:	01010413          	addi	s0,sp,16
    80003be4:	00000097          	auipc	ra,0x0
    80003be8:	a00080e7          	jalr	-1536(ra) # 800035e4 <cpuid>
    80003bec:	00813083          	ld	ra,8(sp)
    80003bf0:	00013403          	ld	s0,0(sp)
    80003bf4:	00d5151b          	slliw	a0,a0,0xd
    80003bf8:	0c2017b7          	lui	a5,0xc201
    80003bfc:	00a78533          	add	a0,a5,a0
    80003c00:	00452503          	lw	a0,4(a0)
    80003c04:	01010113          	addi	sp,sp,16
    80003c08:	00008067          	ret

0000000080003c0c <plic_complete>:
    80003c0c:	fe010113          	addi	sp,sp,-32
    80003c10:	00813823          	sd	s0,16(sp)
    80003c14:	00913423          	sd	s1,8(sp)
    80003c18:	00113c23          	sd	ra,24(sp)
    80003c1c:	02010413          	addi	s0,sp,32
    80003c20:	00050493          	mv	s1,a0
    80003c24:	00000097          	auipc	ra,0x0
    80003c28:	9c0080e7          	jalr	-1600(ra) # 800035e4 <cpuid>
    80003c2c:	01813083          	ld	ra,24(sp)
    80003c30:	01013403          	ld	s0,16(sp)
    80003c34:	00d5179b          	slliw	a5,a0,0xd
    80003c38:	0c201737          	lui	a4,0xc201
    80003c3c:	00f707b3          	add	a5,a4,a5
    80003c40:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80003c44:	00813483          	ld	s1,8(sp)
    80003c48:	02010113          	addi	sp,sp,32
    80003c4c:	00008067          	ret

0000000080003c50 <consolewrite>:
    80003c50:	fb010113          	addi	sp,sp,-80
    80003c54:	04813023          	sd	s0,64(sp)
    80003c58:	04113423          	sd	ra,72(sp)
    80003c5c:	02913c23          	sd	s1,56(sp)
    80003c60:	03213823          	sd	s2,48(sp)
    80003c64:	03313423          	sd	s3,40(sp)
    80003c68:	03413023          	sd	s4,32(sp)
    80003c6c:	01513c23          	sd	s5,24(sp)
    80003c70:	05010413          	addi	s0,sp,80
    80003c74:	06c05c63          	blez	a2,80003cec <consolewrite+0x9c>
    80003c78:	00060993          	mv	s3,a2
    80003c7c:	00050a13          	mv	s4,a0
    80003c80:	00058493          	mv	s1,a1
    80003c84:	00000913          	li	s2,0
    80003c88:	fff00a93          	li	s5,-1
    80003c8c:	01c0006f          	j	80003ca8 <consolewrite+0x58>
    80003c90:	fbf44503          	lbu	a0,-65(s0)
    80003c94:	0019091b          	addiw	s2,s2,1
    80003c98:	00148493          	addi	s1,s1,1
    80003c9c:	00001097          	auipc	ra,0x1
    80003ca0:	a9c080e7          	jalr	-1380(ra) # 80004738 <uartputc>
    80003ca4:	03298063          	beq	s3,s2,80003cc4 <consolewrite+0x74>
    80003ca8:	00048613          	mv	a2,s1
    80003cac:	00100693          	li	a3,1
    80003cb0:	000a0593          	mv	a1,s4
    80003cb4:	fbf40513          	addi	a0,s0,-65
    80003cb8:	00000097          	auipc	ra,0x0
    80003cbc:	9e4080e7          	jalr	-1564(ra) # 8000369c <either_copyin>
    80003cc0:	fd5518e3          	bne	a0,s5,80003c90 <consolewrite+0x40>
    80003cc4:	04813083          	ld	ra,72(sp)
    80003cc8:	04013403          	ld	s0,64(sp)
    80003ccc:	03813483          	ld	s1,56(sp)
    80003cd0:	02813983          	ld	s3,40(sp)
    80003cd4:	02013a03          	ld	s4,32(sp)
    80003cd8:	01813a83          	ld	s5,24(sp)
    80003cdc:	00090513          	mv	a0,s2
    80003ce0:	03013903          	ld	s2,48(sp)
    80003ce4:	05010113          	addi	sp,sp,80
    80003ce8:	00008067          	ret
    80003cec:	00000913          	li	s2,0
    80003cf0:	fd5ff06f          	j	80003cc4 <consolewrite+0x74>

0000000080003cf4 <consoleread>:
    80003cf4:	f9010113          	addi	sp,sp,-112
    80003cf8:	06813023          	sd	s0,96(sp)
    80003cfc:	04913c23          	sd	s1,88(sp)
    80003d00:	05213823          	sd	s2,80(sp)
    80003d04:	05313423          	sd	s3,72(sp)
    80003d08:	05413023          	sd	s4,64(sp)
    80003d0c:	03513c23          	sd	s5,56(sp)
    80003d10:	03613823          	sd	s6,48(sp)
    80003d14:	03713423          	sd	s7,40(sp)
    80003d18:	03813023          	sd	s8,32(sp)
    80003d1c:	06113423          	sd	ra,104(sp)
    80003d20:	01913c23          	sd	s9,24(sp)
    80003d24:	07010413          	addi	s0,sp,112
    80003d28:	00060b93          	mv	s7,a2
    80003d2c:	00050913          	mv	s2,a0
    80003d30:	00058c13          	mv	s8,a1
    80003d34:	00060b1b          	sext.w	s6,a2
    80003d38:	00005497          	auipc	s1,0x5
    80003d3c:	87048493          	addi	s1,s1,-1936 # 800085a8 <cons>
    80003d40:	00400993          	li	s3,4
    80003d44:	fff00a13          	li	s4,-1
    80003d48:	00a00a93          	li	s5,10
    80003d4c:	05705e63          	blez	s7,80003da8 <consoleread+0xb4>
    80003d50:	09c4a703          	lw	a4,156(s1)
    80003d54:	0984a783          	lw	a5,152(s1)
    80003d58:	0007071b          	sext.w	a4,a4
    80003d5c:	08e78463          	beq	a5,a4,80003de4 <consoleread+0xf0>
    80003d60:	07f7f713          	andi	a4,a5,127
    80003d64:	00e48733          	add	a4,s1,a4
    80003d68:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    80003d6c:	0017869b          	addiw	a3,a5,1
    80003d70:	08d4ac23          	sw	a3,152(s1)
    80003d74:	00070c9b          	sext.w	s9,a4
    80003d78:	0b370663          	beq	a4,s3,80003e24 <consoleread+0x130>
    80003d7c:	00100693          	li	a3,1
    80003d80:	f9f40613          	addi	a2,s0,-97
    80003d84:	000c0593          	mv	a1,s8
    80003d88:	00090513          	mv	a0,s2
    80003d8c:	f8e40fa3          	sb	a4,-97(s0)
    80003d90:	00000097          	auipc	ra,0x0
    80003d94:	8c0080e7          	jalr	-1856(ra) # 80003650 <either_copyout>
    80003d98:	01450863          	beq	a0,s4,80003da8 <consoleread+0xb4>
    80003d9c:	001c0c13          	addi	s8,s8,1
    80003da0:	fffb8b9b          	addiw	s7,s7,-1
    80003da4:	fb5c94e3          	bne	s9,s5,80003d4c <consoleread+0x58>
    80003da8:	000b851b          	sext.w	a0,s7
    80003dac:	06813083          	ld	ra,104(sp)
    80003db0:	06013403          	ld	s0,96(sp)
    80003db4:	05813483          	ld	s1,88(sp)
    80003db8:	05013903          	ld	s2,80(sp)
    80003dbc:	04813983          	ld	s3,72(sp)
    80003dc0:	04013a03          	ld	s4,64(sp)
    80003dc4:	03813a83          	ld	s5,56(sp)
    80003dc8:	02813b83          	ld	s7,40(sp)
    80003dcc:	02013c03          	ld	s8,32(sp)
    80003dd0:	01813c83          	ld	s9,24(sp)
    80003dd4:	40ab053b          	subw	a0,s6,a0
    80003dd8:	03013b03          	ld	s6,48(sp)
    80003ddc:	07010113          	addi	sp,sp,112
    80003de0:	00008067          	ret
    80003de4:	00001097          	auipc	ra,0x1
    80003de8:	1d8080e7          	jalr	472(ra) # 80004fbc <push_on>
    80003dec:	0984a703          	lw	a4,152(s1)
    80003df0:	09c4a783          	lw	a5,156(s1)
    80003df4:	0007879b          	sext.w	a5,a5
    80003df8:	fef70ce3          	beq	a4,a5,80003df0 <consoleread+0xfc>
    80003dfc:	00001097          	auipc	ra,0x1
    80003e00:	234080e7          	jalr	564(ra) # 80005030 <pop_on>
    80003e04:	0984a783          	lw	a5,152(s1)
    80003e08:	07f7f713          	andi	a4,a5,127
    80003e0c:	00e48733          	add	a4,s1,a4
    80003e10:	01874703          	lbu	a4,24(a4)
    80003e14:	0017869b          	addiw	a3,a5,1
    80003e18:	08d4ac23          	sw	a3,152(s1)
    80003e1c:	00070c9b          	sext.w	s9,a4
    80003e20:	f5371ee3          	bne	a4,s3,80003d7c <consoleread+0x88>
    80003e24:	000b851b          	sext.w	a0,s7
    80003e28:	f96bf2e3          	bgeu	s7,s6,80003dac <consoleread+0xb8>
    80003e2c:	08f4ac23          	sw	a5,152(s1)
    80003e30:	f7dff06f          	j	80003dac <consoleread+0xb8>

0000000080003e34 <consputc>:
    80003e34:	10000793          	li	a5,256
    80003e38:	00f50663          	beq	a0,a5,80003e44 <consputc+0x10>
    80003e3c:	00001317          	auipc	t1,0x1
    80003e40:	9f430067          	jr	-1548(t1) # 80004830 <uartputc_sync>
    80003e44:	ff010113          	addi	sp,sp,-16
    80003e48:	00113423          	sd	ra,8(sp)
    80003e4c:	00813023          	sd	s0,0(sp)
    80003e50:	01010413          	addi	s0,sp,16
    80003e54:	00800513          	li	a0,8
    80003e58:	00001097          	auipc	ra,0x1
    80003e5c:	9d8080e7          	jalr	-1576(ra) # 80004830 <uartputc_sync>
    80003e60:	02000513          	li	a0,32
    80003e64:	00001097          	auipc	ra,0x1
    80003e68:	9cc080e7          	jalr	-1588(ra) # 80004830 <uartputc_sync>
    80003e6c:	00013403          	ld	s0,0(sp)
    80003e70:	00813083          	ld	ra,8(sp)
    80003e74:	00800513          	li	a0,8
    80003e78:	01010113          	addi	sp,sp,16
    80003e7c:	00001317          	auipc	t1,0x1
    80003e80:	9b430067          	jr	-1612(t1) # 80004830 <uartputc_sync>

0000000080003e84 <consoleintr>:
    80003e84:	fe010113          	addi	sp,sp,-32
    80003e88:	00813823          	sd	s0,16(sp)
    80003e8c:	00913423          	sd	s1,8(sp)
    80003e90:	01213023          	sd	s2,0(sp)
    80003e94:	00113c23          	sd	ra,24(sp)
    80003e98:	02010413          	addi	s0,sp,32
    80003e9c:	00004917          	auipc	s2,0x4
    80003ea0:	70c90913          	addi	s2,s2,1804 # 800085a8 <cons>
    80003ea4:	00050493          	mv	s1,a0
    80003ea8:	00090513          	mv	a0,s2
    80003eac:	00001097          	auipc	ra,0x1
    80003eb0:	e40080e7          	jalr	-448(ra) # 80004cec <acquire>
    80003eb4:	02048c63          	beqz	s1,80003eec <consoleintr+0x68>
    80003eb8:	0a092783          	lw	a5,160(s2)
    80003ebc:	09892703          	lw	a4,152(s2)
    80003ec0:	07f00693          	li	a3,127
    80003ec4:	40e7873b          	subw	a4,a5,a4
    80003ec8:	02e6e263          	bltu	a3,a4,80003eec <consoleintr+0x68>
    80003ecc:	00d00713          	li	a4,13
    80003ed0:	04e48063          	beq	s1,a4,80003f10 <consoleintr+0x8c>
    80003ed4:	07f7f713          	andi	a4,a5,127
    80003ed8:	00e90733          	add	a4,s2,a4
    80003edc:	0017879b          	addiw	a5,a5,1
    80003ee0:	0af92023          	sw	a5,160(s2)
    80003ee4:	00970c23          	sb	s1,24(a4)
    80003ee8:	08f92e23          	sw	a5,156(s2)
    80003eec:	01013403          	ld	s0,16(sp)
    80003ef0:	01813083          	ld	ra,24(sp)
    80003ef4:	00813483          	ld	s1,8(sp)
    80003ef8:	00013903          	ld	s2,0(sp)
    80003efc:	00004517          	auipc	a0,0x4
    80003f00:	6ac50513          	addi	a0,a0,1708 # 800085a8 <cons>
    80003f04:	02010113          	addi	sp,sp,32
    80003f08:	00001317          	auipc	t1,0x1
    80003f0c:	eb030067          	jr	-336(t1) # 80004db8 <release>
    80003f10:	00a00493          	li	s1,10
    80003f14:	fc1ff06f          	j	80003ed4 <consoleintr+0x50>

0000000080003f18 <consoleinit>:
    80003f18:	fe010113          	addi	sp,sp,-32
    80003f1c:	00113c23          	sd	ra,24(sp)
    80003f20:	00813823          	sd	s0,16(sp)
    80003f24:	00913423          	sd	s1,8(sp)
    80003f28:	02010413          	addi	s0,sp,32
    80003f2c:	00004497          	auipc	s1,0x4
    80003f30:	67c48493          	addi	s1,s1,1660 # 800085a8 <cons>
    80003f34:	00048513          	mv	a0,s1
    80003f38:	00002597          	auipc	a1,0x2
    80003f3c:	35858593          	addi	a1,a1,856 # 80006290 <CONSOLE_STATUS+0x280>
    80003f40:	00001097          	auipc	ra,0x1
    80003f44:	d88080e7          	jalr	-632(ra) # 80004cc8 <initlock>
    80003f48:	00000097          	auipc	ra,0x0
    80003f4c:	7ac080e7          	jalr	1964(ra) # 800046f4 <uartinit>
    80003f50:	01813083          	ld	ra,24(sp)
    80003f54:	01013403          	ld	s0,16(sp)
    80003f58:	00000797          	auipc	a5,0x0
    80003f5c:	d9c78793          	addi	a5,a5,-612 # 80003cf4 <consoleread>
    80003f60:	0af4bc23          	sd	a5,184(s1)
    80003f64:	00000797          	auipc	a5,0x0
    80003f68:	cec78793          	addi	a5,a5,-788 # 80003c50 <consolewrite>
    80003f6c:	0cf4b023          	sd	a5,192(s1)
    80003f70:	00813483          	ld	s1,8(sp)
    80003f74:	02010113          	addi	sp,sp,32
    80003f78:	00008067          	ret

0000000080003f7c <console_read>:
    80003f7c:	ff010113          	addi	sp,sp,-16
    80003f80:	00813423          	sd	s0,8(sp)
    80003f84:	01010413          	addi	s0,sp,16
    80003f88:	00813403          	ld	s0,8(sp)
    80003f8c:	00004317          	auipc	t1,0x4
    80003f90:	6d433303          	ld	t1,1748(t1) # 80008660 <devsw+0x10>
    80003f94:	01010113          	addi	sp,sp,16
    80003f98:	00030067          	jr	t1

0000000080003f9c <console_write>:
    80003f9c:	ff010113          	addi	sp,sp,-16
    80003fa0:	00813423          	sd	s0,8(sp)
    80003fa4:	01010413          	addi	s0,sp,16
    80003fa8:	00813403          	ld	s0,8(sp)
    80003fac:	00004317          	auipc	t1,0x4
    80003fb0:	6bc33303          	ld	t1,1724(t1) # 80008668 <devsw+0x18>
    80003fb4:	01010113          	addi	sp,sp,16
    80003fb8:	00030067          	jr	t1

0000000080003fbc <panic>:
    80003fbc:	fe010113          	addi	sp,sp,-32
    80003fc0:	00113c23          	sd	ra,24(sp)
    80003fc4:	00813823          	sd	s0,16(sp)
    80003fc8:	00913423          	sd	s1,8(sp)
    80003fcc:	02010413          	addi	s0,sp,32
    80003fd0:	00050493          	mv	s1,a0
    80003fd4:	00002517          	auipc	a0,0x2
    80003fd8:	2c450513          	addi	a0,a0,708 # 80006298 <CONSOLE_STATUS+0x288>
    80003fdc:	00004797          	auipc	a5,0x4
    80003fe0:	7207a623          	sw	zero,1836(a5) # 80008708 <pr+0x18>
    80003fe4:	00000097          	auipc	ra,0x0
    80003fe8:	034080e7          	jalr	52(ra) # 80004018 <__printf>
    80003fec:	00048513          	mv	a0,s1
    80003ff0:	00000097          	auipc	ra,0x0
    80003ff4:	028080e7          	jalr	40(ra) # 80004018 <__printf>
    80003ff8:	00002517          	auipc	a0,0x2
    80003ffc:	28050513          	addi	a0,a0,640 # 80006278 <CONSOLE_STATUS+0x268>
    80004000:	00000097          	auipc	ra,0x0
    80004004:	018080e7          	jalr	24(ra) # 80004018 <__printf>
    80004008:	00100793          	li	a5,1
    8000400c:	00003717          	auipc	a4,0x3
    80004010:	42f72623          	sw	a5,1068(a4) # 80007438 <panicked>
    80004014:	0000006f          	j	80004014 <panic+0x58>

0000000080004018 <__printf>:
    80004018:	f3010113          	addi	sp,sp,-208
    8000401c:	08813023          	sd	s0,128(sp)
    80004020:	07313423          	sd	s3,104(sp)
    80004024:	09010413          	addi	s0,sp,144
    80004028:	05813023          	sd	s8,64(sp)
    8000402c:	08113423          	sd	ra,136(sp)
    80004030:	06913c23          	sd	s1,120(sp)
    80004034:	07213823          	sd	s2,112(sp)
    80004038:	07413023          	sd	s4,96(sp)
    8000403c:	05513c23          	sd	s5,88(sp)
    80004040:	05613823          	sd	s6,80(sp)
    80004044:	05713423          	sd	s7,72(sp)
    80004048:	03913c23          	sd	s9,56(sp)
    8000404c:	03a13823          	sd	s10,48(sp)
    80004050:	03b13423          	sd	s11,40(sp)
    80004054:	00004317          	auipc	t1,0x4
    80004058:	69c30313          	addi	t1,t1,1692 # 800086f0 <pr>
    8000405c:	01832c03          	lw	s8,24(t1)
    80004060:	00b43423          	sd	a1,8(s0)
    80004064:	00c43823          	sd	a2,16(s0)
    80004068:	00d43c23          	sd	a3,24(s0)
    8000406c:	02e43023          	sd	a4,32(s0)
    80004070:	02f43423          	sd	a5,40(s0)
    80004074:	03043823          	sd	a6,48(s0)
    80004078:	03143c23          	sd	a7,56(s0)
    8000407c:	00050993          	mv	s3,a0
    80004080:	4a0c1663          	bnez	s8,8000452c <__printf+0x514>
    80004084:	60098c63          	beqz	s3,8000469c <__printf+0x684>
    80004088:	0009c503          	lbu	a0,0(s3)
    8000408c:	00840793          	addi	a5,s0,8
    80004090:	f6f43c23          	sd	a5,-136(s0)
    80004094:	00000493          	li	s1,0
    80004098:	22050063          	beqz	a0,800042b8 <__printf+0x2a0>
    8000409c:	00002a37          	lui	s4,0x2
    800040a0:	00018ab7          	lui	s5,0x18
    800040a4:	000f4b37          	lui	s6,0xf4
    800040a8:	00989bb7          	lui	s7,0x989
    800040ac:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    800040b0:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    800040b4:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    800040b8:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    800040bc:	00148c9b          	addiw	s9,s1,1
    800040c0:	02500793          	li	a5,37
    800040c4:	01998933          	add	s2,s3,s9
    800040c8:	38f51263          	bne	a0,a5,8000444c <__printf+0x434>
    800040cc:	00094783          	lbu	a5,0(s2)
    800040d0:	00078c9b          	sext.w	s9,a5
    800040d4:	1e078263          	beqz	a5,800042b8 <__printf+0x2a0>
    800040d8:	0024849b          	addiw	s1,s1,2
    800040dc:	07000713          	li	a4,112
    800040e0:	00998933          	add	s2,s3,s1
    800040e4:	38e78a63          	beq	a5,a4,80004478 <__printf+0x460>
    800040e8:	20f76863          	bltu	a4,a5,800042f8 <__printf+0x2e0>
    800040ec:	42a78863          	beq	a5,a0,8000451c <__printf+0x504>
    800040f0:	06400713          	li	a4,100
    800040f4:	40e79663          	bne	a5,a4,80004500 <__printf+0x4e8>
    800040f8:	f7843783          	ld	a5,-136(s0)
    800040fc:	0007a603          	lw	a2,0(a5)
    80004100:	00878793          	addi	a5,a5,8
    80004104:	f6f43c23          	sd	a5,-136(s0)
    80004108:	42064a63          	bltz	a2,8000453c <__printf+0x524>
    8000410c:	00a00713          	li	a4,10
    80004110:	02e677bb          	remuw	a5,a2,a4
    80004114:	00002d97          	auipc	s11,0x2
    80004118:	1acd8d93          	addi	s11,s11,428 # 800062c0 <digits>
    8000411c:	00900593          	li	a1,9
    80004120:	0006051b          	sext.w	a0,a2
    80004124:	00000c93          	li	s9,0
    80004128:	02079793          	slli	a5,a5,0x20
    8000412c:	0207d793          	srli	a5,a5,0x20
    80004130:	00fd87b3          	add	a5,s11,a5
    80004134:	0007c783          	lbu	a5,0(a5)
    80004138:	02e656bb          	divuw	a3,a2,a4
    8000413c:	f8f40023          	sb	a5,-128(s0)
    80004140:	14c5d863          	bge	a1,a2,80004290 <__printf+0x278>
    80004144:	06300593          	li	a1,99
    80004148:	00100c93          	li	s9,1
    8000414c:	02e6f7bb          	remuw	a5,a3,a4
    80004150:	02079793          	slli	a5,a5,0x20
    80004154:	0207d793          	srli	a5,a5,0x20
    80004158:	00fd87b3          	add	a5,s11,a5
    8000415c:	0007c783          	lbu	a5,0(a5)
    80004160:	02e6d73b          	divuw	a4,a3,a4
    80004164:	f8f400a3          	sb	a5,-127(s0)
    80004168:	12a5f463          	bgeu	a1,a0,80004290 <__printf+0x278>
    8000416c:	00a00693          	li	a3,10
    80004170:	00900593          	li	a1,9
    80004174:	02d777bb          	remuw	a5,a4,a3
    80004178:	02079793          	slli	a5,a5,0x20
    8000417c:	0207d793          	srli	a5,a5,0x20
    80004180:	00fd87b3          	add	a5,s11,a5
    80004184:	0007c503          	lbu	a0,0(a5)
    80004188:	02d757bb          	divuw	a5,a4,a3
    8000418c:	f8a40123          	sb	a0,-126(s0)
    80004190:	48e5f263          	bgeu	a1,a4,80004614 <__printf+0x5fc>
    80004194:	06300513          	li	a0,99
    80004198:	02d7f5bb          	remuw	a1,a5,a3
    8000419c:	02059593          	slli	a1,a1,0x20
    800041a0:	0205d593          	srli	a1,a1,0x20
    800041a4:	00bd85b3          	add	a1,s11,a1
    800041a8:	0005c583          	lbu	a1,0(a1)
    800041ac:	02d7d7bb          	divuw	a5,a5,a3
    800041b0:	f8b401a3          	sb	a1,-125(s0)
    800041b4:	48e57263          	bgeu	a0,a4,80004638 <__printf+0x620>
    800041b8:	3e700513          	li	a0,999
    800041bc:	02d7f5bb          	remuw	a1,a5,a3
    800041c0:	02059593          	slli	a1,a1,0x20
    800041c4:	0205d593          	srli	a1,a1,0x20
    800041c8:	00bd85b3          	add	a1,s11,a1
    800041cc:	0005c583          	lbu	a1,0(a1)
    800041d0:	02d7d7bb          	divuw	a5,a5,a3
    800041d4:	f8b40223          	sb	a1,-124(s0)
    800041d8:	46e57663          	bgeu	a0,a4,80004644 <__printf+0x62c>
    800041dc:	02d7f5bb          	remuw	a1,a5,a3
    800041e0:	02059593          	slli	a1,a1,0x20
    800041e4:	0205d593          	srli	a1,a1,0x20
    800041e8:	00bd85b3          	add	a1,s11,a1
    800041ec:	0005c583          	lbu	a1,0(a1)
    800041f0:	02d7d7bb          	divuw	a5,a5,a3
    800041f4:	f8b402a3          	sb	a1,-123(s0)
    800041f8:	46ea7863          	bgeu	s4,a4,80004668 <__printf+0x650>
    800041fc:	02d7f5bb          	remuw	a1,a5,a3
    80004200:	02059593          	slli	a1,a1,0x20
    80004204:	0205d593          	srli	a1,a1,0x20
    80004208:	00bd85b3          	add	a1,s11,a1
    8000420c:	0005c583          	lbu	a1,0(a1)
    80004210:	02d7d7bb          	divuw	a5,a5,a3
    80004214:	f8b40323          	sb	a1,-122(s0)
    80004218:	3eeaf863          	bgeu	s5,a4,80004608 <__printf+0x5f0>
    8000421c:	02d7f5bb          	remuw	a1,a5,a3
    80004220:	02059593          	slli	a1,a1,0x20
    80004224:	0205d593          	srli	a1,a1,0x20
    80004228:	00bd85b3          	add	a1,s11,a1
    8000422c:	0005c583          	lbu	a1,0(a1)
    80004230:	02d7d7bb          	divuw	a5,a5,a3
    80004234:	f8b403a3          	sb	a1,-121(s0)
    80004238:	42eb7e63          	bgeu	s6,a4,80004674 <__printf+0x65c>
    8000423c:	02d7f5bb          	remuw	a1,a5,a3
    80004240:	02059593          	slli	a1,a1,0x20
    80004244:	0205d593          	srli	a1,a1,0x20
    80004248:	00bd85b3          	add	a1,s11,a1
    8000424c:	0005c583          	lbu	a1,0(a1)
    80004250:	02d7d7bb          	divuw	a5,a5,a3
    80004254:	f8b40423          	sb	a1,-120(s0)
    80004258:	42ebfc63          	bgeu	s7,a4,80004690 <__printf+0x678>
    8000425c:	02079793          	slli	a5,a5,0x20
    80004260:	0207d793          	srli	a5,a5,0x20
    80004264:	00fd8db3          	add	s11,s11,a5
    80004268:	000dc703          	lbu	a4,0(s11)
    8000426c:	00a00793          	li	a5,10
    80004270:	00900c93          	li	s9,9
    80004274:	f8e404a3          	sb	a4,-119(s0)
    80004278:	00065c63          	bgez	a2,80004290 <__printf+0x278>
    8000427c:	f9040713          	addi	a4,s0,-112
    80004280:	00f70733          	add	a4,a4,a5
    80004284:	02d00693          	li	a3,45
    80004288:	fed70823          	sb	a3,-16(a4)
    8000428c:	00078c93          	mv	s9,a5
    80004290:	f8040793          	addi	a5,s0,-128
    80004294:	01978cb3          	add	s9,a5,s9
    80004298:	f7f40d13          	addi	s10,s0,-129
    8000429c:	000cc503          	lbu	a0,0(s9)
    800042a0:	fffc8c93          	addi	s9,s9,-1
    800042a4:	00000097          	auipc	ra,0x0
    800042a8:	b90080e7          	jalr	-1136(ra) # 80003e34 <consputc>
    800042ac:	ffac98e3          	bne	s9,s10,8000429c <__printf+0x284>
    800042b0:	00094503          	lbu	a0,0(s2)
    800042b4:	e00514e3          	bnez	a0,800040bc <__printf+0xa4>
    800042b8:	1a0c1663          	bnez	s8,80004464 <__printf+0x44c>
    800042bc:	08813083          	ld	ra,136(sp)
    800042c0:	08013403          	ld	s0,128(sp)
    800042c4:	07813483          	ld	s1,120(sp)
    800042c8:	07013903          	ld	s2,112(sp)
    800042cc:	06813983          	ld	s3,104(sp)
    800042d0:	06013a03          	ld	s4,96(sp)
    800042d4:	05813a83          	ld	s5,88(sp)
    800042d8:	05013b03          	ld	s6,80(sp)
    800042dc:	04813b83          	ld	s7,72(sp)
    800042e0:	04013c03          	ld	s8,64(sp)
    800042e4:	03813c83          	ld	s9,56(sp)
    800042e8:	03013d03          	ld	s10,48(sp)
    800042ec:	02813d83          	ld	s11,40(sp)
    800042f0:	0d010113          	addi	sp,sp,208
    800042f4:	00008067          	ret
    800042f8:	07300713          	li	a4,115
    800042fc:	1ce78a63          	beq	a5,a4,800044d0 <__printf+0x4b8>
    80004300:	07800713          	li	a4,120
    80004304:	1ee79e63          	bne	a5,a4,80004500 <__printf+0x4e8>
    80004308:	f7843783          	ld	a5,-136(s0)
    8000430c:	0007a703          	lw	a4,0(a5)
    80004310:	00878793          	addi	a5,a5,8
    80004314:	f6f43c23          	sd	a5,-136(s0)
    80004318:	28074263          	bltz	a4,8000459c <__printf+0x584>
    8000431c:	00002d97          	auipc	s11,0x2
    80004320:	fa4d8d93          	addi	s11,s11,-92 # 800062c0 <digits>
    80004324:	00f77793          	andi	a5,a4,15
    80004328:	00fd87b3          	add	a5,s11,a5
    8000432c:	0007c683          	lbu	a3,0(a5)
    80004330:	00f00613          	li	a2,15
    80004334:	0007079b          	sext.w	a5,a4
    80004338:	f8d40023          	sb	a3,-128(s0)
    8000433c:	0047559b          	srliw	a1,a4,0x4
    80004340:	0047569b          	srliw	a3,a4,0x4
    80004344:	00000c93          	li	s9,0
    80004348:	0ee65063          	bge	a2,a4,80004428 <__printf+0x410>
    8000434c:	00f6f693          	andi	a3,a3,15
    80004350:	00dd86b3          	add	a3,s11,a3
    80004354:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80004358:	0087d79b          	srliw	a5,a5,0x8
    8000435c:	00100c93          	li	s9,1
    80004360:	f8d400a3          	sb	a3,-127(s0)
    80004364:	0cb67263          	bgeu	a2,a1,80004428 <__printf+0x410>
    80004368:	00f7f693          	andi	a3,a5,15
    8000436c:	00dd86b3          	add	a3,s11,a3
    80004370:	0006c583          	lbu	a1,0(a3)
    80004374:	00f00613          	li	a2,15
    80004378:	0047d69b          	srliw	a3,a5,0x4
    8000437c:	f8b40123          	sb	a1,-126(s0)
    80004380:	0047d593          	srli	a1,a5,0x4
    80004384:	28f67e63          	bgeu	a2,a5,80004620 <__printf+0x608>
    80004388:	00f6f693          	andi	a3,a3,15
    8000438c:	00dd86b3          	add	a3,s11,a3
    80004390:	0006c503          	lbu	a0,0(a3)
    80004394:	0087d813          	srli	a6,a5,0x8
    80004398:	0087d69b          	srliw	a3,a5,0x8
    8000439c:	f8a401a3          	sb	a0,-125(s0)
    800043a0:	28b67663          	bgeu	a2,a1,8000462c <__printf+0x614>
    800043a4:	00f6f693          	andi	a3,a3,15
    800043a8:	00dd86b3          	add	a3,s11,a3
    800043ac:	0006c583          	lbu	a1,0(a3)
    800043b0:	00c7d513          	srli	a0,a5,0xc
    800043b4:	00c7d69b          	srliw	a3,a5,0xc
    800043b8:	f8b40223          	sb	a1,-124(s0)
    800043bc:	29067a63          	bgeu	a2,a6,80004650 <__printf+0x638>
    800043c0:	00f6f693          	andi	a3,a3,15
    800043c4:	00dd86b3          	add	a3,s11,a3
    800043c8:	0006c583          	lbu	a1,0(a3)
    800043cc:	0107d813          	srli	a6,a5,0x10
    800043d0:	0107d69b          	srliw	a3,a5,0x10
    800043d4:	f8b402a3          	sb	a1,-123(s0)
    800043d8:	28a67263          	bgeu	a2,a0,8000465c <__printf+0x644>
    800043dc:	00f6f693          	andi	a3,a3,15
    800043e0:	00dd86b3          	add	a3,s11,a3
    800043e4:	0006c683          	lbu	a3,0(a3)
    800043e8:	0147d79b          	srliw	a5,a5,0x14
    800043ec:	f8d40323          	sb	a3,-122(s0)
    800043f0:	21067663          	bgeu	a2,a6,800045fc <__printf+0x5e4>
    800043f4:	02079793          	slli	a5,a5,0x20
    800043f8:	0207d793          	srli	a5,a5,0x20
    800043fc:	00fd8db3          	add	s11,s11,a5
    80004400:	000dc683          	lbu	a3,0(s11)
    80004404:	00800793          	li	a5,8
    80004408:	00700c93          	li	s9,7
    8000440c:	f8d403a3          	sb	a3,-121(s0)
    80004410:	00075c63          	bgez	a4,80004428 <__printf+0x410>
    80004414:	f9040713          	addi	a4,s0,-112
    80004418:	00f70733          	add	a4,a4,a5
    8000441c:	02d00693          	li	a3,45
    80004420:	fed70823          	sb	a3,-16(a4)
    80004424:	00078c93          	mv	s9,a5
    80004428:	f8040793          	addi	a5,s0,-128
    8000442c:	01978cb3          	add	s9,a5,s9
    80004430:	f7f40d13          	addi	s10,s0,-129
    80004434:	000cc503          	lbu	a0,0(s9)
    80004438:	fffc8c93          	addi	s9,s9,-1
    8000443c:	00000097          	auipc	ra,0x0
    80004440:	9f8080e7          	jalr	-1544(ra) # 80003e34 <consputc>
    80004444:	ff9d18e3          	bne	s10,s9,80004434 <__printf+0x41c>
    80004448:	0100006f          	j	80004458 <__printf+0x440>
    8000444c:	00000097          	auipc	ra,0x0
    80004450:	9e8080e7          	jalr	-1560(ra) # 80003e34 <consputc>
    80004454:	000c8493          	mv	s1,s9
    80004458:	00094503          	lbu	a0,0(s2)
    8000445c:	c60510e3          	bnez	a0,800040bc <__printf+0xa4>
    80004460:	e40c0ee3          	beqz	s8,800042bc <__printf+0x2a4>
    80004464:	00004517          	auipc	a0,0x4
    80004468:	28c50513          	addi	a0,a0,652 # 800086f0 <pr>
    8000446c:	00001097          	auipc	ra,0x1
    80004470:	94c080e7          	jalr	-1716(ra) # 80004db8 <release>
    80004474:	e49ff06f          	j	800042bc <__printf+0x2a4>
    80004478:	f7843783          	ld	a5,-136(s0)
    8000447c:	03000513          	li	a0,48
    80004480:	01000d13          	li	s10,16
    80004484:	00878713          	addi	a4,a5,8
    80004488:	0007bc83          	ld	s9,0(a5)
    8000448c:	f6e43c23          	sd	a4,-136(s0)
    80004490:	00000097          	auipc	ra,0x0
    80004494:	9a4080e7          	jalr	-1628(ra) # 80003e34 <consputc>
    80004498:	07800513          	li	a0,120
    8000449c:	00000097          	auipc	ra,0x0
    800044a0:	998080e7          	jalr	-1640(ra) # 80003e34 <consputc>
    800044a4:	00002d97          	auipc	s11,0x2
    800044a8:	e1cd8d93          	addi	s11,s11,-484 # 800062c0 <digits>
    800044ac:	03ccd793          	srli	a5,s9,0x3c
    800044b0:	00fd87b3          	add	a5,s11,a5
    800044b4:	0007c503          	lbu	a0,0(a5)
    800044b8:	fffd0d1b          	addiw	s10,s10,-1
    800044bc:	004c9c93          	slli	s9,s9,0x4
    800044c0:	00000097          	auipc	ra,0x0
    800044c4:	974080e7          	jalr	-1676(ra) # 80003e34 <consputc>
    800044c8:	fe0d12e3          	bnez	s10,800044ac <__printf+0x494>
    800044cc:	f8dff06f          	j	80004458 <__printf+0x440>
    800044d0:	f7843783          	ld	a5,-136(s0)
    800044d4:	0007bc83          	ld	s9,0(a5)
    800044d8:	00878793          	addi	a5,a5,8
    800044dc:	f6f43c23          	sd	a5,-136(s0)
    800044e0:	000c9a63          	bnez	s9,800044f4 <__printf+0x4dc>
    800044e4:	1080006f          	j	800045ec <__printf+0x5d4>
    800044e8:	001c8c93          	addi	s9,s9,1
    800044ec:	00000097          	auipc	ra,0x0
    800044f0:	948080e7          	jalr	-1720(ra) # 80003e34 <consputc>
    800044f4:	000cc503          	lbu	a0,0(s9)
    800044f8:	fe0518e3          	bnez	a0,800044e8 <__printf+0x4d0>
    800044fc:	f5dff06f          	j	80004458 <__printf+0x440>
    80004500:	02500513          	li	a0,37
    80004504:	00000097          	auipc	ra,0x0
    80004508:	930080e7          	jalr	-1744(ra) # 80003e34 <consputc>
    8000450c:	000c8513          	mv	a0,s9
    80004510:	00000097          	auipc	ra,0x0
    80004514:	924080e7          	jalr	-1756(ra) # 80003e34 <consputc>
    80004518:	f41ff06f          	j	80004458 <__printf+0x440>
    8000451c:	02500513          	li	a0,37
    80004520:	00000097          	auipc	ra,0x0
    80004524:	914080e7          	jalr	-1772(ra) # 80003e34 <consputc>
    80004528:	f31ff06f          	j	80004458 <__printf+0x440>
    8000452c:	00030513          	mv	a0,t1
    80004530:	00000097          	auipc	ra,0x0
    80004534:	7bc080e7          	jalr	1980(ra) # 80004cec <acquire>
    80004538:	b4dff06f          	j	80004084 <__printf+0x6c>
    8000453c:	40c0053b          	negw	a0,a2
    80004540:	00a00713          	li	a4,10
    80004544:	02e576bb          	remuw	a3,a0,a4
    80004548:	00002d97          	auipc	s11,0x2
    8000454c:	d78d8d93          	addi	s11,s11,-648 # 800062c0 <digits>
    80004550:	ff700593          	li	a1,-9
    80004554:	02069693          	slli	a3,a3,0x20
    80004558:	0206d693          	srli	a3,a3,0x20
    8000455c:	00dd86b3          	add	a3,s11,a3
    80004560:	0006c683          	lbu	a3,0(a3)
    80004564:	02e557bb          	divuw	a5,a0,a4
    80004568:	f8d40023          	sb	a3,-128(s0)
    8000456c:	10b65e63          	bge	a2,a1,80004688 <__printf+0x670>
    80004570:	06300593          	li	a1,99
    80004574:	02e7f6bb          	remuw	a3,a5,a4
    80004578:	02069693          	slli	a3,a3,0x20
    8000457c:	0206d693          	srli	a3,a3,0x20
    80004580:	00dd86b3          	add	a3,s11,a3
    80004584:	0006c683          	lbu	a3,0(a3)
    80004588:	02e7d73b          	divuw	a4,a5,a4
    8000458c:	00200793          	li	a5,2
    80004590:	f8d400a3          	sb	a3,-127(s0)
    80004594:	bca5ece3          	bltu	a1,a0,8000416c <__printf+0x154>
    80004598:	ce5ff06f          	j	8000427c <__printf+0x264>
    8000459c:	40e007bb          	negw	a5,a4
    800045a0:	00002d97          	auipc	s11,0x2
    800045a4:	d20d8d93          	addi	s11,s11,-736 # 800062c0 <digits>
    800045a8:	00f7f693          	andi	a3,a5,15
    800045ac:	00dd86b3          	add	a3,s11,a3
    800045b0:	0006c583          	lbu	a1,0(a3)
    800045b4:	ff100613          	li	a2,-15
    800045b8:	0047d69b          	srliw	a3,a5,0x4
    800045bc:	f8b40023          	sb	a1,-128(s0)
    800045c0:	0047d59b          	srliw	a1,a5,0x4
    800045c4:	0ac75e63          	bge	a4,a2,80004680 <__printf+0x668>
    800045c8:	00f6f693          	andi	a3,a3,15
    800045cc:	00dd86b3          	add	a3,s11,a3
    800045d0:	0006c603          	lbu	a2,0(a3)
    800045d4:	00f00693          	li	a3,15
    800045d8:	0087d79b          	srliw	a5,a5,0x8
    800045dc:	f8c400a3          	sb	a2,-127(s0)
    800045e0:	d8b6e4e3          	bltu	a3,a1,80004368 <__printf+0x350>
    800045e4:	00200793          	li	a5,2
    800045e8:	e2dff06f          	j	80004414 <__printf+0x3fc>
    800045ec:	00002c97          	auipc	s9,0x2
    800045f0:	cb4c8c93          	addi	s9,s9,-844 # 800062a0 <CONSOLE_STATUS+0x290>
    800045f4:	02800513          	li	a0,40
    800045f8:	ef1ff06f          	j	800044e8 <__printf+0x4d0>
    800045fc:	00700793          	li	a5,7
    80004600:	00600c93          	li	s9,6
    80004604:	e0dff06f          	j	80004410 <__printf+0x3f8>
    80004608:	00700793          	li	a5,7
    8000460c:	00600c93          	li	s9,6
    80004610:	c69ff06f          	j	80004278 <__printf+0x260>
    80004614:	00300793          	li	a5,3
    80004618:	00200c93          	li	s9,2
    8000461c:	c5dff06f          	j	80004278 <__printf+0x260>
    80004620:	00300793          	li	a5,3
    80004624:	00200c93          	li	s9,2
    80004628:	de9ff06f          	j	80004410 <__printf+0x3f8>
    8000462c:	00400793          	li	a5,4
    80004630:	00300c93          	li	s9,3
    80004634:	dddff06f          	j	80004410 <__printf+0x3f8>
    80004638:	00400793          	li	a5,4
    8000463c:	00300c93          	li	s9,3
    80004640:	c39ff06f          	j	80004278 <__printf+0x260>
    80004644:	00500793          	li	a5,5
    80004648:	00400c93          	li	s9,4
    8000464c:	c2dff06f          	j	80004278 <__printf+0x260>
    80004650:	00500793          	li	a5,5
    80004654:	00400c93          	li	s9,4
    80004658:	db9ff06f          	j	80004410 <__printf+0x3f8>
    8000465c:	00600793          	li	a5,6
    80004660:	00500c93          	li	s9,5
    80004664:	dadff06f          	j	80004410 <__printf+0x3f8>
    80004668:	00600793          	li	a5,6
    8000466c:	00500c93          	li	s9,5
    80004670:	c09ff06f          	j	80004278 <__printf+0x260>
    80004674:	00800793          	li	a5,8
    80004678:	00700c93          	li	s9,7
    8000467c:	bfdff06f          	j	80004278 <__printf+0x260>
    80004680:	00100793          	li	a5,1
    80004684:	d91ff06f          	j	80004414 <__printf+0x3fc>
    80004688:	00100793          	li	a5,1
    8000468c:	bf1ff06f          	j	8000427c <__printf+0x264>
    80004690:	00900793          	li	a5,9
    80004694:	00800c93          	li	s9,8
    80004698:	be1ff06f          	j	80004278 <__printf+0x260>
    8000469c:	00002517          	auipc	a0,0x2
    800046a0:	c0c50513          	addi	a0,a0,-1012 # 800062a8 <CONSOLE_STATUS+0x298>
    800046a4:	00000097          	auipc	ra,0x0
    800046a8:	918080e7          	jalr	-1768(ra) # 80003fbc <panic>

00000000800046ac <printfinit>:
    800046ac:	fe010113          	addi	sp,sp,-32
    800046b0:	00813823          	sd	s0,16(sp)
    800046b4:	00913423          	sd	s1,8(sp)
    800046b8:	00113c23          	sd	ra,24(sp)
    800046bc:	02010413          	addi	s0,sp,32
    800046c0:	00004497          	auipc	s1,0x4
    800046c4:	03048493          	addi	s1,s1,48 # 800086f0 <pr>
    800046c8:	00048513          	mv	a0,s1
    800046cc:	00002597          	auipc	a1,0x2
    800046d0:	bec58593          	addi	a1,a1,-1044 # 800062b8 <CONSOLE_STATUS+0x2a8>
    800046d4:	00000097          	auipc	ra,0x0
    800046d8:	5f4080e7          	jalr	1524(ra) # 80004cc8 <initlock>
    800046dc:	01813083          	ld	ra,24(sp)
    800046e0:	01013403          	ld	s0,16(sp)
    800046e4:	0004ac23          	sw	zero,24(s1)
    800046e8:	00813483          	ld	s1,8(sp)
    800046ec:	02010113          	addi	sp,sp,32
    800046f0:	00008067          	ret

00000000800046f4 <uartinit>:
    800046f4:	ff010113          	addi	sp,sp,-16
    800046f8:	00813423          	sd	s0,8(sp)
    800046fc:	01010413          	addi	s0,sp,16
    80004700:	100007b7          	lui	a5,0x10000
    80004704:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80004708:	f8000713          	li	a4,-128
    8000470c:	00e781a3          	sb	a4,3(a5)
    80004710:	00300713          	li	a4,3
    80004714:	00e78023          	sb	a4,0(a5)
    80004718:	000780a3          	sb	zero,1(a5)
    8000471c:	00e781a3          	sb	a4,3(a5)
    80004720:	00700693          	li	a3,7
    80004724:	00d78123          	sb	a3,2(a5)
    80004728:	00e780a3          	sb	a4,1(a5)
    8000472c:	00813403          	ld	s0,8(sp)
    80004730:	01010113          	addi	sp,sp,16
    80004734:	00008067          	ret

0000000080004738 <uartputc>:
    80004738:	00003797          	auipc	a5,0x3
    8000473c:	d007a783          	lw	a5,-768(a5) # 80007438 <panicked>
    80004740:	00078463          	beqz	a5,80004748 <uartputc+0x10>
    80004744:	0000006f          	j	80004744 <uartputc+0xc>
    80004748:	fd010113          	addi	sp,sp,-48
    8000474c:	02813023          	sd	s0,32(sp)
    80004750:	00913c23          	sd	s1,24(sp)
    80004754:	01213823          	sd	s2,16(sp)
    80004758:	01313423          	sd	s3,8(sp)
    8000475c:	02113423          	sd	ra,40(sp)
    80004760:	03010413          	addi	s0,sp,48
    80004764:	00003917          	auipc	s2,0x3
    80004768:	cdc90913          	addi	s2,s2,-804 # 80007440 <uart_tx_r>
    8000476c:	00093783          	ld	a5,0(s2)
    80004770:	00003497          	auipc	s1,0x3
    80004774:	cd848493          	addi	s1,s1,-808 # 80007448 <uart_tx_w>
    80004778:	0004b703          	ld	a4,0(s1)
    8000477c:	02078693          	addi	a3,a5,32
    80004780:	00050993          	mv	s3,a0
    80004784:	02e69c63          	bne	a3,a4,800047bc <uartputc+0x84>
    80004788:	00001097          	auipc	ra,0x1
    8000478c:	834080e7          	jalr	-1996(ra) # 80004fbc <push_on>
    80004790:	00093783          	ld	a5,0(s2)
    80004794:	0004b703          	ld	a4,0(s1)
    80004798:	02078793          	addi	a5,a5,32
    8000479c:	00e79463          	bne	a5,a4,800047a4 <uartputc+0x6c>
    800047a0:	0000006f          	j	800047a0 <uartputc+0x68>
    800047a4:	00001097          	auipc	ra,0x1
    800047a8:	88c080e7          	jalr	-1908(ra) # 80005030 <pop_on>
    800047ac:	00093783          	ld	a5,0(s2)
    800047b0:	0004b703          	ld	a4,0(s1)
    800047b4:	02078693          	addi	a3,a5,32
    800047b8:	fce688e3          	beq	a3,a4,80004788 <uartputc+0x50>
    800047bc:	01f77693          	andi	a3,a4,31
    800047c0:	00004597          	auipc	a1,0x4
    800047c4:	f5058593          	addi	a1,a1,-176 # 80008710 <uart_tx_buf>
    800047c8:	00d586b3          	add	a3,a1,a3
    800047cc:	00170713          	addi	a4,a4,1
    800047d0:	01368023          	sb	s3,0(a3)
    800047d4:	00e4b023          	sd	a4,0(s1)
    800047d8:	10000637          	lui	a2,0x10000
    800047dc:	02f71063          	bne	a4,a5,800047fc <uartputc+0xc4>
    800047e0:	0340006f          	j	80004814 <uartputc+0xdc>
    800047e4:	00074703          	lbu	a4,0(a4)
    800047e8:	00f93023          	sd	a5,0(s2)
    800047ec:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    800047f0:	00093783          	ld	a5,0(s2)
    800047f4:	0004b703          	ld	a4,0(s1)
    800047f8:	00f70e63          	beq	a4,a5,80004814 <uartputc+0xdc>
    800047fc:	00564683          	lbu	a3,5(a2)
    80004800:	01f7f713          	andi	a4,a5,31
    80004804:	00e58733          	add	a4,a1,a4
    80004808:	0206f693          	andi	a3,a3,32
    8000480c:	00178793          	addi	a5,a5,1
    80004810:	fc069ae3          	bnez	a3,800047e4 <uartputc+0xac>
    80004814:	02813083          	ld	ra,40(sp)
    80004818:	02013403          	ld	s0,32(sp)
    8000481c:	01813483          	ld	s1,24(sp)
    80004820:	01013903          	ld	s2,16(sp)
    80004824:	00813983          	ld	s3,8(sp)
    80004828:	03010113          	addi	sp,sp,48
    8000482c:	00008067          	ret

0000000080004830 <uartputc_sync>:
    80004830:	ff010113          	addi	sp,sp,-16
    80004834:	00813423          	sd	s0,8(sp)
    80004838:	01010413          	addi	s0,sp,16
    8000483c:	00003717          	auipc	a4,0x3
    80004840:	bfc72703          	lw	a4,-1028(a4) # 80007438 <panicked>
    80004844:	02071663          	bnez	a4,80004870 <uartputc_sync+0x40>
    80004848:	00050793          	mv	a5,a0
    8000484c:	100006b7          	lui	a3,0x10000
    80004850:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80004854:	02077713          	andi	a4,a4,32
    80004858:	fe070ce3          	beqz	a4,80004850 <uartputc_sync+0x20>
    8000485c:	0ff7f793          	andi	a5,a5,255
    80004860:	00f68023          	sb	a5,0(a3)
    80004864:	00813403          	ld	s0,8(sp)
    80004868:	01010113          	addi	sp,sp,16
    8000486c:	00008067          	ret
    80004870:	0000006f          	j	80004870 <uartputc_sync+0x40>

0000000080004874 <uartstart>:
    80004874:	ff010113          	addi	sp,sp,-16
    80004878:	00813423          	sd	s0,8(sp)
    8000487c:	01010413          	addi	s0,sp,16
    80004880:	00003617          	auipc	a2,0x3
    80004884:	bc060613          	addi	a2,a2,-1088 # 80007440 <uart_tx_r>
    80004888:	00003517          	auipc	a0,0x3
    8000488c:	bc050513          	addi	a0,a0,-1088 # 80007448 <uart_tx_w>
    80004890:	00063783          	ld	a5,0(a2)
    80004894:	00053703          	ld	a4,0(a0)
    80004898:	04f70263          	beq	a4,a5,800048dc <uartstart+0x68>
    8000489c:	100005b7          	lui	a1,0x10000
    800048a0:	00004817          	auipc	a6,0x4
    800048a4:	e7080813          	addi	a6,a6,-400 # 80008710 <uart_tx_buf>
    800048a8:	01c0006f          	j	800048c4 <uartstart+0x50>
    800048ac:	0006c703          	lbu	a4,0(a3)
    800048b0:	00f63023          	sd	a5,0(a2)
    800048b4:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800048b8:	00063783          	ld	a5,0(a2)
    800048bc:	00053703          	ld	a4,0(a0)
    800048c0:	00f70e63          	beq	a4,a5,800048dc <uartstart+0x68>
    800048c4:	01f7f713          	andi	a4,a5,31
    800048c8:	00e806b3          	add	a3,a6,a4
    800048cc:	0055c703          	lbu	a4,5(a1)
    800048d0:	00178793          	addi	a5,a5,1
    800048d4:	02077713          	andi	a4,a4,32
    800048d8:	fc071ae3          	bnez	a4,800048ac <uartstart+0x38>
    800048dc:	00813403          	ld	s0,8(sp)
    800048e0:	01010113          	addi	sp,sp,16
    800048e4:	00008067          	ret

00000000800048e8 <uartgetc>:
    800048e8:	ff010113          	addi	sp,sp,-16
    800048ec:	00813423          	sd	s0,8(sp)
    800048f0:	01010413          	addi	s0,sp,16
    800048f4:	10000737          	lui	a4,0x10000
    800048f8:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    800048fc:	0017f793          	andi	a5,a5,1
    80004900:	00078c63          	beqz	a5,80004918 <uartgetc+0x30>
    80004904:	00074503          	lbu	a0,0(a4)
    80004908:	0ff57513          	andi	a0,a0,255
    8000490c:	00813403          	ld	s0,8(sp)
    80004910:	01010113          	addi	sp,sp,16
    80004914:	00008067          	ret
    80004918:	fff00513          	li	a0,-1
    8000491c:	ff1ff06f          	j	8000490c <uartgetc+0x24>

0000000080004920 <uartintr>:
    80004920:	100007b7          	lui	a5,0x10000
    80004924:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80004928:	0017f793          	andi	a5,a5,1
    8000492c:	0a078463          	beqz	a5,800049d4 <uartintr+0xb4>
    80004930:	fe010113          	addi	sp,sp,-32
    80004934:	00813823          	sd	s0,16(sp)
    80004938:	00913423          	sd	s1,8(sp)
    8000493c:	00113c23          	sd	ra,24(sp)
    80004940:	02010413          	addi	s0,sp,32
    80004944:	100004b7          	lui	s1,0x10000
    80004948:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    8000494c:	0ff57513          	andi	a0,a0,255
    80004950:	fffff097          	auipc	ra,0xfffff
    80004954:	534080e7          	jalr	1332(ra) # 80003e84 <consoleintr>
    80004958:	0054c783          	lbu	a5,5(s1)
    8000495c:	0017f793          	andi	a5,a5,1
    80004960:	fe0794e3          	bnez	a5,80004948 <uartintr+0x28>
    80004964:	00003617          	auipc	a2,0x3
    80004968:	adc60613          	addi	a2,a2,-1316 # 80007440 <uart_tx_r>
    8000496c:	00003517          	auipc	a0,0x3
    80004970:	adc50513          	addi	a0,a0,-1316 # 80007448 <uart_tx_w>
    80004974:	00063783          	ld	a5,0(a2)
    80004978:	00053703          	ld	a4,0(a0)
    8000497c:	04f70263          	beq	a4,a5,800049c0 <uartintr+0xa0>
    80004980:	100005b7          	lui	a1,0x10000
    80004984:	00004817          	auipc	a6,0x4
    80004988:	d8c80813          	addi	a6,a6,-628 # 80008710 <uart_tx_buf>
    8000498c:	01c0006f          	j	800049a8 <uartintr+0x88>
    80004990:	0006c703          	lbu	a4,0(a3)
    80004994:	00f63023          	sd	a5,0(a2)
    80004998:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000499c:	00063783          	ld	a5,0(a2)
    800049a0:	00053703          	ld	a4,0(a0)
    800049a4:	00f70e63          	beq	a4,a5,800049c0 <uartintr+0xa0>
    800049a8:	01f7f713          	andi	a4,a5,31
    800049ac:	00e806b3          	add	a3,a6,a4
    800049b0:	0055c703          	lbu	a4,5(a1)
    800049b4:	00178793          	addi	a5,a5,1
    800049b8:	02077713          	andi	a4,a4,32
    800049bc:	fc071ae3          	bnez	a4,80004990 <uartintr+0x70>
    800049c0:	01813083          	ld	ra,24(sp)
    800049c4:	01013403          	ld	s0,16(sp)
    800049c8:	00813483          	ld	s1,8(sp)
    800049cc:	02010113          	addi	sp,sp,32
    800049d0:	00008067          	ret
    800049d4:	00003617          	auipc	a2,0x3
    800049d8:	a6c60613          	addi	a2,a2,-1428 # 80007440 <uart_tx_r>
    800049dc:	00003517          	auipc	a0,0x3
    800049e0:	a6c50513          	addi	a0,a0,-1428 # 80007448 <uart_tx_w>
    800049e4:	00063783          	ld	a5,0(a2)
    800049e8:	00053703          	ld	a4,0(a0)
    800049ec:	04f70263          	beq	a4,a5,80004a30 <uartintr+0x110>
    800049f0:	100005b7          	lui	a1,0x10000
    800049f4:	00004817          	auipc	a6,0x4
    800049f8:	d1c80813          	addi	a6,a6,-740 # 80008710 <uart_tx_buf>
    800049fc:	01c0006f          	j	80004a18 <uartintr+0xf8>
    80004a00:	0006c703          	lbu	a4,0(a3)
    80004a04:	00f63023          	sd	a5,0(a2)
    80004a08:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80004a0c:	00063783          	ld	a5,0(a2)
    80004a10:	00053703          	ld	a4,0(a0)
    80004a14:	02f70063          	beq	a4,a5,80004a34 <uartintr+0x114>
    80004a18:	01f7f713          	andi	a4,a5,31
    80004a1c:	00e806b3          	add	a3,a6,a4
    80004a20:	0055c703          	lbu	a4,5(a1)
    80004a24:	00178793          	addi	a5,a5,1
    80004a28:	02077713          	andi	a4,a4,32
    80004a2c:	fc071ae3          	bnez	a4,80004a00 <uartintr+0xe0>
    80004a30:	00008067          	ret
    80004a34:	00008067          	ret

0000000080004a38 <kinit>:
    80004a38:	fc010113          	addi	sp,sp,-64
    80004a3c:	02913423          	sd	s1,40(sp)
    80004a40:	fffff7b7          	lui	a5,0xfffff
    80004a44:	00005497          	auipc	s1,0x5
    80004a48:	ceb48493          	addi	s1,s1,-789 # 8000972f <end+0xfff>
    80004a4c:	02813823          	sd	s0,48(sp)
    80004a50:	01313c23          	sd	s3,24(sp)
    80004a54:	00f4f4b3          	and	s1,s1,a5
    80004a58:	02113c23          	sd	ra,56(sp)
    80004a5c:	03213023          	sd	s2,32(sp)
    80004a60:	01413823          	sd	s4,16(sp)
    80004a64:	01513423          	sd	s5,8(sp)
    80004a68:	04010413          	addi	s0,sp,64
    80004a6c:	000017b7          	lui	a5,0x1
    80004a70:	01100993          	li	s3,17
    80004a74:	00f487b3          	add	a5,s1,a5
    80004a78:	01b99993          	slli	s3,s3,0x1b
    80004a7c:	06f9e063          	bltu	s3,a5,80004adc <kinit+0xa4>
    80004a80:	00004a97          	auipc	s5,0x4
    80004a84:	cb0a8a93          	addi	s5,s5,-848 # 80008730 <end>
    80004a88:	0754ec63          	bltu	s1,s5,80004b00 <kinit+0xc8>
    80004a8c:	0734fa63          	bgeu	s1,s3,80004b00 <kinit+0xc8>
    80004a90:	00088a37          	lui	s4,0x88
    80004a94:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80004a98:	00003917          	auipc	s2,0x3
    80004a9c:	9b890913          	addi	s2,s2,-1608 # 80007450 <kmem>
    80004aa0:	00ca1a13          	slli	s4,s4,0xc
    80004aa4:	0140006f          	j	80004ab8 <kinit+0x80>
    80004aa8:	000017b7          	lui	a5,0x1
    80004aac:	00f484b3          	add	s1,s1,a5
    80004ab0:	0554e863          	bltu	s1,s5,80004b00 <kinit+0xc8>
    80004ab4:	0534f663          	bgeu	s1,s3,80004b00 <kinit+0xc8>
    80004ab8:	00001637          	lui	a2,0x1
    80004abc:	00100593          	li	a1,1
    80004ac0:	00048513          	mv	a0,s1
    80004ac4:	00000097          	auipc	ra,0x0
    80004ac8:	5e4080e7          	jalr	1508(ra) # 800050a8 <__memset>
    80004acc:	00093783          	ld	a5,0(s2)
    80004ad0:	00f4b023          	sd	a5,0(s1)
    80004ad4:	00993023          	sd	s1,0(s2)
    80004ad8:	fd4498e3          	bne	s1,s4,80004aa8 <kinit+0x70>
    80004adc:	03813083          	ld	ra,56(sp)
    80004ae0:	03013403          	ld	s0,48(sp)
    80004ae4:	02813483          	ld	s1,40(sp)
    80004ae8:	02013903          	ld	s2,32(sp)
    80004aec:	01813983          	ld	s3,24(sp)
    80004af0:	01013a03          	ld	s4,16(sp)
    80004af4:	00813a83          	ld	s5,8(sp)
    80004af8:	04010113          	addi	sp,sp,64
    80004afc:	00008067          	ret
    80004b00:	00001517          	auipc	a0,0x1
    80004b04:	7d850513          	addi	a0,a0,2008 # 800062d8 <digits+0x18>
    80004b08:	fffff097          	auipc	ra,0xfffff
    80004b0c:	4b4080e7          	jalr	1204(ra) # 80003fbc <panic>

0000000080004b10 <freerange>:
    80004b10:	fc010113          	addi	sp,sp,-64
    80004b14:	000017b7          	lui	a5,0x1
    80004b18:	02913423          	sd	s1,40(sp)
    80004b1c:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80004b20:	009504b3          	add	s1,a0,s1
    80004b24:	fffff537          	lui	a0,0xfffff
    80004b28:	02813823          	sd	s0,48(sp)
    80004b2c:	02113c23          	sd	ra,56(sp)
    80004b30:	03213023          	sd	s2,32(sp)
    80004b34:	01313c23          	sd	s3,24(sp)
    80004b38:	01413823          	sd	s4,16(sp)
    80004b3c:	01513423          	sd	s5,8(sp)
    80004b40:	01613023          	sd	s6,0(sp)
    80004b44:	04010413          	addi	s0,sp,64
    80004b48:	00a4f4b3          	and	s1,s1,a0
    80004b4c:	00f487b3          	add	a5,s1,a5
    80004b50:	06f5e463          	bltu	a1,a5,80004bb8 <freerange+0xa8>
    80004b54:	00004a97          	auipc	s5,0x4
    80004b58:	bdca8a93          	addi	s5,s5,-1060 # 80008730 <end>
    80004b5c:	0954e263          	bltu	s1,s5,80004be0 <freerange+0xd0>
    80004b60:	01100993          	li	s3,17
    80004b64:	01b99993          	slli	s3,s3,0x1b
    80004b68:	0734fc63          	bgeu	s1,s3,80004be0 <freerange+0xd0>
    80004b6c:	00058a13          	mv	s4,a1
    80004b70:	00003917          	auipc	s2,0x3
    80004b74:	8e090913          	addi	s2,s2,-1824 # 80007450 <kmem>
    80004b78:	00002b37          	lui	s6,0x2
    80004b7c:	0140006f          	j	80004b90 <freerange+0x80>
    80004b80:	000017b7          	lui	a5,0x1
    80004b84:	00f484b3          	add	s1,s1,a5
    80004b88:	0554ec63          	bltu	s1,s5,80004be0 <freerange+0xd0>
    80004b8c:	0534fa63          	bgeu	s1,s3,80004be0 <freerange+0xd0>
    80004b90:	00001637          	lui	a2,0x1
    80004b94:	00100593          	li	a1,1
    80004b98:	00048513          	mv	a0,s1
    80004b9c:	00000097          	auipc	ra,0x0
    80004ba0:	50c080e7          	jalr	1292(ra) # 800050a8 <__memset>
    80004ba4:	00093703          	ld	a4,0(s2)
    80004ba8:	016487b3          	add	a5,s1,s6
    80004bac:	00e4b023          	sd	a4,0(s1)
    80004bb0:	00993023          	sd	s1,0(s2)
    80004bb4:	fcfa76e3          	bgeu	s4,a5,80004b80 <freerange+0x70>
    80004bb8:	03813083          	ld	ra,56(sp)
    80004bbc:	03013403          	ld	s0,48(sp)
    80004bc0:	02813483          	ld	s1,40(sp)
    80004bc4:	02013903          	ld	s2,32(sp)
    80004bc8:	01813983          	ld	s3,24(sp)
    80004bcc:	01013a03          	ld	s4,16(sp)
    80004bd0:	00813a83          	ld	s5,8(sp)
    80004bd4:	00013b03          	ld	s6,0(sp)
    80004bd8:	04010113          	addi	sp,sp,64
    80004bdc:	00008067          	ret
    80004be0:	00001517          	auipc	a0,0x1
    80004be4:	6f850513          	addi	a0,a0,1784 # 800062d8 <digits+0x18>
    80004be8:	fffff097          	auipc	ra,0xfffff
    80004bec:	3d4080e7          	jalr	980(ra) # 80003fbc <panic>

0000000080004bf0 <kfree>:
    80004bf0:	fe010113          	addi	sp,sp,-32
    80004bf4:	00813823          	sd	s0,16(sp)
    80004bf8:	00113c23          	sd	ra,24(sp)
    80004bfc:	00913423          	sd	s1,8(sp)
    80004c00:	02010413          	addi	s0,sp,32
    80004c04:	03451793          	slli	a5,a0,0x34
    80004c08:	04079c63          	bnez	a5,80004c60 <kfree+0x70>
    80004c0c:	00004797          	auipc	a5,0x4
    80004c10:	b2478793          	addi	a5,a5,-1244 # 80008730 <end>
    80004c14:	00050493          	mv	s1,a0
    80004c18:	04f56463          	bltu	a0,a5,80004c60 <kfree+0x70>
    80004c1c:	01100793          	li	a5,17
    80004c20:	01b79793          	slli	a5,a5,0x1b
    80004c24:	02f57e63          	bgeu	a0,a5,80004c60 <kfree+0x70>
    80004c28:	00001637          	lui	a2,0x1
    80004c2c:	00100593          	li	a1,1
    80004c30:	00000097          	auipc	ra,0x0
    80004c34:	478080e7          	jalr	1144(ra) # 800050a8 <__memset>
    80004c38:	00003797          	auipc	a5,0x3
    80004c3c:	81878793          	addi	a5,a5,-2024 # 80007450 <kmem>
    80004c40:	0007b703          	ld	a4,0(a5)
    80004c44:	01813083          	ld	ra,24(sp)
    80004c48:	01013403          	ld	s0,16(sp)
    80004c4c:	00e4b023          	sd	a4,0(s1)
    80004c50:	0097b023          	sd	s1,0(a5)
    80004c54:	00813483          	ld	s1,8(sp)
    80004c58:	02010113          	addi	sp,sp,32
    80004c5c:	00008067          	ret
    80004c60:	00001517          	auipc	a0,0x1
    80004c64:	67850513          	addi	a0,a0,1656 # 800062d8 <digits+0x18>
    80004c68:	fffff097          	auipc	ra,0xfffff
    80004c6c:	354080e7          	jalr	852(ra) # 80003fbc <panic>

0000000080004c70 <kalloc>:
    80004c70:	fe010113          	addi	sp,sp,-32
    80004c74:	00813823          	sd	s0,16(sp)
    80004c78:	00913423          	sd	s1,8(sp)
    80004c7c:	00113c23          	sd	ra,24(sp)
    80004c80:	02010413          	addi	s0,sp,32
    80004c84:	00002797          	auipc	a5,0x2
    80004c88:	7cc78793          	addi	a5,a5,1996 # 80007450 <kmem>
    80004c8c:	0007b483          	ld	s1,0(a5)
    80004c90:	02048063          	beqz	s1,80004cb0 <kalloc+0x40>
    80004c94:	0004b703          	ld	a4,0(s1)
    80004c98:	00001637          	lui	a2,0x1
    80004c9c:	00500593          	li	a1,5
    80004ca0:	00048513          	mv	a0,s1
    80004ca4:	00e7b023          	sd	a4,0(a5)
    80004ca8:	00000097          	auipc	ra,0x0
    80004cac:	400080e7          	jalr	1024(ra) # 800050a8 <__memset>
    80004cb0:	01813083          	ld	ra,24(sp)
    80004cb4:	01013403          	ld	s0,16(sp)
    80004cb8:	00048513          	mv	a0,s1
    80004cbc:	00813483          	ld	s1,8(sp)
    80004cc0:	02010113          	addi	sp,sp,32
    80004cc4:	00008067          	ret

0000000080004cc8 <initlock>:
    80004cc8:	ff010113          	addi	sp,sp,-16
    80004ccc:	00813423          	sd	s0,8(sp)
    80004cd0:	01010413          	addi	s0,sp,16
    80004cd4:	00813403          	ld	s0,8(sp)
    80004cd8:	00b53423          	sd	a1,8(a0)
    80004cdc:	00052023          	sw	zero,0(a0)
    80004ce0:	00053823          	sd	zero,16(a0)
    80004ce4:	01010113          	addi	sp,sp,16
    80004ce8:	00008067          	ret

0000000080004cec <acquire>:
    80004cec:	fe010113          	addi	sp,sp,-32
    80004cf0:	00813823          	sd	s0,16(sp)
    80004cf4:	00913423          	sd	s1,8(sp)
    80004cf8:	00113c23          	sd	ra,24(sp)
    80004cfc:	01213023          	sd	s2,0(sp)
    80004d00:	02010413          	addi	s0,sp,32
    80004d04:	00050493          	mv	s1,a0
    80004d08:	10002973          	csrr	s2,sstatus
    80004d0c:	100027f3          	csrr	a5,sstatus
    80004d10:	ffd7f793          	andi	a5,a5,-3
    80004d14:	10079073          	csrw	sstatus,a5
    80004d18:	fffff097          	auipc	ra,0xfffff
    80004d1c:	8ec080e7          	jalr	-1812(ra) # 80003604 <mycpu>
    80004d20:	07852783          	lw	a5,120(a0)
    80004d24:	06078e63          	beqz	a5,80004da0 <acquire+0xb4>
    80004d28:	fffff097          	auipc	ra,0xfffff
    80004d2c:	8dc080e7          	jalr	-1828(ra) # 80003604 <mycpu>
    80004d30:	07852783          	lw	a5,120(a0)
    80004d34:	0004a703          	lw	a4,0(s1)
    80004d38:	0017879b          	addiw	a5,a5,1
    80004d3c:	06f52c23          	sw	a5,120(a0)
    80004d40:	04071063          	bnez	a4,80004d80 <acquire+0x94>
    80004d44:	00100713          	li	a4,1
    80004d48:	00070793          	mv	a5,a4
    80004d4c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80004d50:	0007879b          	sext.w	a5,a5
    80004d54:	fe079ae3          	bnez	a5,80004d48 <acquire+0x5c>
    80004d58:	0ff0000f          	fence
    80004d5c:	fffff097          	auipc	ra,0xfffff
    80004d60:	8a8080e7          	jalr	-1880(ra) # 80003604 <mycpu>
    80004d64:	01813083          	ld	ra,24(sp)
    80004d68:	01013403          	ld	s0,16(sp)
    80004d6c:	00a4b823          	sd	a0,16(s1)
    80004d70:	00013903          	ld	s2,0(sp)
    80004d74:	00813483          	ld	s1,8(sp)
    80004d78:	02010113          	addi	sp,sp,32
    80004d7c:	00008067          	ret
    80004d80:	0104b903          	ld	s2,16(s1)
    80004d84:	fffff097          	auipc	ra,0xfffff
    80004d88:	880080e7          	jalr	-1920(ra) # 80003604 <mycpu>
    80004d8c:	faa91ce3          	bne	s2,a0,80004d44 <acquire+0x58>
    80004d90:	00001517          	auipc	a0,0x1
    80004d94:	55050513          	addi	a0,a0,1360 # 800062e0 <digits+0x20>
    80004d98:	fffff097          	auipc	ra,0xfffff
    80004d9c:	224080e7          	jalr	548(ra) # 80003fbc <panic>
    80004da0:	00195913          	srli	s2,s2,0x1
    80004da4:	fffff097          	auipc	ra,0xfffff
    80004da8:	860080e7          	jalr	-1952(ra) # 80003604 <mycpu>
    80004dac:	00197913          	andi	s2,s2,1
    80004db0:	07252e23          	sw	s2,124(a0)
    80004db4:	f75ff06f          	j	80004d28 <acquire+0x3c>

0000000080004db8 <release>:
    80004db8:	fe010113          	addi	sp,sp,-32
    80004dbc:	00813823          	sd	s0,16(sp)
    80004dc0:	00113c23          	sd	ra,24(sp)
    80004dc4:	00913423          	sd	s1,8(sp)
    80004dc8:	01213023          	sd	s2,0(sp)
    80004dcc:	02010413          	addi	s0,sp,32
    80004dd0:	00052783          	lw	a5,0(a0)
    80004dd4:	00079a63          	bnez	a5,80004de8 <release+0x30>
    80004dd8:	00001517          	auipc	a0,0x1
    80004ddc:	51050513          	addi	a0,a0,1296 # 800062e8 <digits+0x28>
    80004de0:	fffff097          	auipc	ra,0xfffff
    80004de4:	1dc080e7          	jalr	476(ra) # 80003fbc <panic>
    80004de8:	01053903          	ld	s2,16(a0)
    80004dec:	00050493          	mv	s1,a0
    80004df0:	fffff097          	auipc	ra,0xfffff
    80004df4:	814080e7          	jalr	-2028(ra) # 80003604 <mycpu>
    80004df8:	fea910e3          	bne	s2,a0,80004dd8 <release+0x20>
    80004dfc:	0004b823          	sd	zero,16(s1)
    80004e00:	0ff0000f          	fence
    80004e04:	0f50000f          	fence	iorw,ow
    80004e08:	0804a02f          	amoswap.w	zero,zero,(s1)
    80004e0c:	ffffe097          	auipc	ra,0xffffe
    80004e10:	7f8080e7          	jalr	2040(ra) # 80003604 <mycpu>
    80004e14:	100027f3          	csrr	a5,sstatus
    80004e18:	0027f793          	andi	a5,a5,2
    80004e1c:	04079a63          	bnez	a5,80004e70 <release+0xb8>
    80004e20:	07852783          	lw	a5,120(a0)
    80004e24:	02f05e63          	blez	a5,80004e60 <release+0xa8>
    80004e28:	fff7871b          	addiw	a4,a5,-1
    80004e2c:	06e52c23          	sw	a4,120(a0)
    80004e30:	00071c63          	bnez	a4,80004e48 <release+0x90>
    80004e34:	07c52783          	lw	a5,124(a0)
    80004e38:	00078863          	beqz	a5,80004e48 <release+0x90>
    80004e3c:	100027f3          	csrr	a5,sstatus
    80004e40:	0027e793          	ori	a5,a5,2
    80004e44:	10079073          	csrw	sstatus,a5
    80004e48:	01813083          	ld	ra,24(sp)
    80004e4c:	01013403          	ld	s0,16(sp)
    80004e50:	00813483          	ld	s1,8(sp)
    80004e54:	00013903          	ld	s2,0(sp)
    80004e58:	02010113          	addi	sp,sp,32
    80004e5c:	00008067          	ret
    80004e60:	00001517          	auipc	a0,0x1
    80004e64:	4a850513          	addi	a0,a0,1192 # 80006308 <digits+0x48>
    80004e68:	fffff097          	auipc	ra,0xfffff
    80004e6c:	154080e7          	jalr	340(ra) # 80003fbc <panic>
    80004e70:	00001517          	auipc	a0,0x1
    80004e74:	48050513          	addi	a0,a0,1152 # 800062f0 <digits+0x30>
    80004e78:	fffff097          	auipc	ra,0xfffff
    80004e7c:	144080e7          	jalr	324(ra) # 80003fbc <panic>

0000000080004e80 <holding>:
    80004e80:	00052783          	lw	a5,0(a0)
    80004e84:	00079663          	bnez	a5,80004e90 <holding+0x10>
    80004e88:	00000513          	li	a0,0
    80004e8c:	00008067          	ret
    80004e90:	fe010113          	addi	sp,sp,-32
    80004e94:	00813823          	sd	s0,16(sp)
    80004e98:	00913423          	sd	s1,8(sp)
    80004e9c:	00113c23          	sd	ra,24(sp)
    80004ea0:	02010413          	addi	s0,sp,32
    80004ea4:	01053483          	ld	s1,16(a0)
    80004ea8:	ffffe097          	auipc	ra,0xffffe
    80004eac:	75c080e7          	jalr	1884(ra) # 80003604 <mycpu>
    80004eb0:	01813083          	ld	ra,24(sp)
    80004eb4:	01013403          	ld	s0,16(sp)
    80004eb8:	40a48533          	sub	a0,s1,a0
    80004ebc:	00153513          	seqz	a0,a0
    80004ec0:	00813483          	ld	s1,8(sp)
    80004ec4:	02010113          	addi	sp,sp,32
    80004ec8:	00008067          	ret

0000000080004ecc <push_off>:
    80004ecc:	fe010113          	addi	sp,sp,-32
    80004ed0:	00813823          	sd	s0,16(sp)
    80004ed4:	00113c23          	sd	ra,24(sp)
    80004ed8:	00913423          	sd	s1,8(sp)
    80004edc:	02010413          	addi	s0,sp,32
    80004ee0:	100024f3          	csrr	s1,sstatus
    80004ee4:	100027f3          	csrr	a5,sstatus
    80004ee8:	ffd7f793          	andi	a5,a5,-3
    80004eec:	10079073          	csrw	sstatus,a5
    80004ef0:	ffffe097          	auipc	ra,0xffffe
    80004ef4:	714080e7          	jalr	1812(ra) # 80003604 <mycpu>
    80004ef8:	07852783          	lw	a5,120(a0)
    80004efc:	02078663          	beqz	a5,80004f28 <push_off+0x5c>
    80004f00:	ffffe097          	auipc	ra,0xffffe
    80004f04:	704080e7          	jalr	1796(ra) # 80003604 <mycpu>
    80004f08:	07852783          	lw	a5,120(a0)
    80004f0c:	01813083          	ld	ra,24(sp)
    80004f10:	01013403          	ld	s0,16(sp)
    80004f14:	0017879b          	addiw	a5,a5,1
    80004f18:	06f52c23          	sw	a5,120(a0)
    80004f1c:	00813483          	ld	s1,8(sp)
    80004f20:	02010113          	addi	sp,sp,32
    80004f24:	00008067          	ret
    80004f28:	0014d493          	srli	s1,s1,0x1
    80004f2c:	ffffe097          	auipc	ra,0xffffe
    80004f30:	6d8080e7          	jalr	1752(ra) # 80003604 <mycpu>
    80004f34:	0014f493          	andi	s1,s1,1
    80004f38:	06952e23          	sw	s1,124(a0)
    80004f3c:	fc5ff06f          	j	80004f00 <push_off+0x34>

0000000080004f40 <pop_off>:
    80004f40:	ff010113          	addi	sp,sp,-16
    80004f44:	00813023          	sd	s0,0(sp)
    80004f48:	00113423          	sd	ra,8(sp)
    80004f4c:	01010413          	addi	s0,sp,16
    80004f50:	ffffe097          	auipc	ra,0xffffe
    80004f54:	6b4080e7          	jalr	1716(ra) # 80003604 <mycpu>
    80004f58:	100027f3          	csrr	a5,sstatus
    80004f5c:	0027f793          	andi	a5,a5,2
    80004f60:	04079663          	bnez	a5,80004fac <pop_off+0x6c>
    80004f64:	07852783          	lw	a5,120(a0)
    80004f68:	02f05a63          	blez	a5,80004f9c <pop_off+0x5c>
    80004f6c:	fff7871b          	addiw	a4,a5,-1
    80004f70:	06e52c23          	sw	a4,120(a0)
    80004f74:	00071c63          	bnez	a4,80004f8c <pop_off+0x4c>
    80004f78:	07c52783          	lw	a5,124(a0)
    80004f7c:	00078863          	beqz	a5,80004f8c <pop_off+0x4c>
    80004f80:	100027f3          	csrr	a5,sstatus
    80004f84:	0027e793          	ori	a5,a5,2
    80004f88:	10079073          	csrw	sstatus,a5
    80004f8c:	00813083          	ld	ra,8(sp)
    80004f90:	00013403          	ld	s0,0(sp)
    80004f94:	01010113          	addi	sp,sp,16
    80004f98:	00008067          	ret
    80004f9c:	00001517          	auipc	a0,0x1
    80004fa0:	36c50513          	addi	a0,a0,876 # 80006308 <digits+0x48>
    80004fa4:	fffff097          	auipc	ra,0xfffff
    80004fa8:	018080e7          	jalr	24(ra) # 80003fbc <panic>
    80004fac:	00001517          	auipc	a0,0x1
    80004fb0:	34450513          	addi	a0,a0,836 # 800062f0 <digits+0x30>
    80004fb4:	fffff097          	auipc	ra,0xfffff
    80004fb8:	008080e7          	jalr	8(ra) # 80003fbc <panic>

0000000080004fbc <push_on>:
    80004fbc:	fe010113          	addi	sp,sp,-32
    80004fc0:	00813823          	sd	s0,16(sp)
    80004fc4:	00113c23          	sd	ra,24(sp)
    80004fc8:	00913423          	sd	s1,8(sp)
    80004fcc:	02010413          	addi	s0,sp,32
    80004fd0:	100024f3          	csrr	s1,sstatus
    80004fd4:	100027f3          	csrr	a5,sstatus
    80004fd8:	0027e793          	ori	a5,a5,2
    80004fdc:	10079073          	csrw	sstatus,a5
    80004fe0:	ffffe097          	auipc	ra,0xffffe
    80004fe4:	624080e7          	jalr	1572(ra) # 80003604 <mycpu>
    80004fe8:	07852783          	lw	a5,120(a0)
    80004fec:	02078663          	beqz	a5,80005018 <push_on+0x5c>
    80004ff0:	ffffe097          	auipc	ra,0xffffe
    80004ff4:	614080e7          	jalr	1556(ra) # 80003604 <mycpu>
    80004ff8:	07852783          	lw	a5,120(a0)
    80004ffc:	01813083          	ld	ra,24(sp)
    80005000:	01013403          	ld	s0,16(sp)
    80005004:	0017879b          	addiw	a5,a5,1
    80005008:	06f52c23          	sw	a5,120(a0)
    8000500c:	00813483          	ld	s1,8(sp)
    80005010:	02010113          	addi	sp,sp,32
    80005014:	00008067          	ret
    80005018:	0014d493          	srli	s1,s1,0x1
    8000501c:	ffffe097          	auipc	ra,0xffffe
    80005020:	5e8080e7          	jalr	1512(ra) # 80003604 <mycpu>
    80005024:	0014f493          	andi	s1,s1,1
    80005028:	06952e23          	sw	s1,124(a0)
    8000502c:	fc5ff06f          	j	80004ff0 <push_on+0x34>

0000000080005030 <pop_on>:
    80005030:	ff010113          	addi	sp,sp,-16
    80005034:	00813023          	sd	s0,0(sp)
    80005038:	00113423          	sd	ra,8(sp)
    8000503c:	01010413          	addi	s0,sp,16
    80005040:	ffffe097          	auipc	ra,0xffffe
    80005044:	5c4080e7          	jalr	1476(ra) # 80003604 <mycpu>
    80005048:	100027f3          	csrr	a5,sstatus
    8000504c:	0027f793          	andi	a5,a5,2
    80005050:	04078463          	beqz	a5,80005098 <pop_on+0x68>
    80005054:	07852783          	lw	a5,120(a0)
    80005058:	02f05863          	blez	a5,80005088 <pop_on+0x58>
    8000505c:	fff7879b          	addiw	a5,a5,-1
    80005060:	06f52c23          	sw	a5,120(a0)
    80005064:	07853783          	ld	a5,120(a0)
    80005068:	00079863          	bnez	a5,80005078 <pop_on+0x48>
    8000506c:	100027f3          	csrr	a5,sstatus
    80005070:	ffd7f793          	andi	a5,a5,-3
    80005074:	10079073          	csrw	sstatus,a5
    80005078:	00813083          	ld	ra,8(sp)
    8000507c:	00013403          	ld	s0,0(sp)
    80005080:	01010113          	addi	sp,sp,16
    80005084:	00008067          	ret
    80005088:	00001517          	auipc	a0,0x1
    8000508c:	2a850513          	addi	a0,a0,680 # 80006330 <digits+0x70>
    80005090:	fffff097          	auipc	ra,0xfffff
    80005094:	f2c080e7          	jalr	-212(ra) # 80003fbc <panic>
    80005098:	00001517          	auipc	a0,0x1
    8000509c:	27850513          	addi	a0,a0,632 # 80006310 <digits+0x50>
    800050a0:	fffff097          	auipc	ra,0xfffff
    800050a4:	f1c080e7          	jalr	-228(ra) # 80003fbc <panic>

00000000800050a8 <__memset>:
    800050a8:	ff010113          	addi	sp,sp,-16
    800050ac:	00813423          	sd	s0,8(sp)
    800050b0:	01010413          	addi	s0,sp,16
    800050b4:	1a060e63          	beqz	a2,80005270 <__memset+0x1c8>
    800050b8:	40a007b3          	neg	a5,a0
    800050bc:	0077f793          	andi	a5,a5,7
    800050c0:	00778693          	addi	a3,a5,7
    800050c4:	00b00813          	li	a6,11
    800050c8:	0ff5f593          	andi	a1,a1,255
    800050cc:	fff6071b          	addiw	a4,a2,-1
    800050d0:	1b06e663          	bltu	a3,a6,8000527c <__memset+0x1d4>
    800050d4:	1cd76463          	bltu	a4,a3,8000529c <__memset+0x1f4>
    800050d8:	1a078e63          	beqz	a5,80005294 <__memset+0x1ec>
    800050dc:	00b50023          	sb	a1,0(a0)
    800050e0:	00100713          	li	a4,1
    800050e4:	1ae78463          	beq	a5,a4,8000528c <__memset+0x1e4>
    800050e8:	00b500a3          	sb	a1,1(a0)
    800050ec:	00200713          	li	a4,2
    800050f0:	1ae78a63          	beq	a5,a4,800052a4 <__memset+0x1fc>
    800050f4:	00b50123          	sb	a1,2(a0)
    800050f8:	00300713          	li	a4,3
    800050fc:	18e78463          	beq	a5,a4,80005284 <__memset+0x1dc>
    80005100:	00b501a3          	sb	a1,3(a0)
    80005104:	00400713          	li	a4,4
    80005108:	1ae78263          	beq	a5,a4,800052ac <__memset+0x204>
    8000510c:	00b50223          	sb	a1,4(a0)
    80005110:	00500713          	li	a4,5
    80005114:	1ae78063          	beq	a5,a4,800052b4 <__memset+0x20c>
    80005118:	00b502a3          	sb	a1,5(a0)
    8000511c:	00700713          	li	a4,7
    80005120:	18e79e63          	bne	a5,a4,800052bc <__memset+0x214>
    80005124:	00b50323          	sb	a1,6(a0)
    80005128:	00700e93          	li	t4,7
    8000512c:	00859713          	slli	a4,a1,0x8
    80005130:	00e5e733          	or	a4,a1,a4
    80005134:	01059e13          	slli	t3,a1,0x10
    80005138:	01c76e33          	or	t3,a4,t3
    8000513c:	01859313          	slli	t1,a1,0x18
    80005140:	006e6333          	or	t1,t3,t1
    80005144:	02059893          	slli	a7,a1,0x20
    80005148:	40f60e3b          	subw	t3,a2,a5
    8000514c:	011368b3          	or	a7,t1,a7
    80005150:	02859813          	slli	a6,a1,0x28
    80005154:	0108e833          	or	a6,a7,a6
    80005158:	03059693          	slli	a3,a1,0x30
    8000515c:	003e589b          	srliw	a7,t3,0x3
    80005160:	00d866b3          	or	a3,a6,a3
    80005164:	03859713          	slli	a4,a1,0x38
    80005168:	00389813          	slli	a6,a7,0x3
    8000516c:	00f507b3          	add	a5,a0,a5
    80005170:	00e6e733          	or	a4,a3,a4
    80005174:	000e089b          	sext.w	a7,t3
    80005178:	00f806b3          	add	a3,a6,a5
    8000517c:	00e7b023          	sd	a4,0(a5)
    80005180:	00878793          	addi	a5,a5,8
    80005184:	fed79ce3          	bne	a5,a3,8000517c <__memset+0xd4>
    80005188:	ff8e7793          	andi	a5,t3,-8
    8000518c:	0007871b          	sext.w	a4,a5
    80005190:	01d787bb          	addw	a5,a5,t4
    80005194:	0ce88e63          	beq	a7,a4,80005270 <__memset+0x1c8>
    80005198:	00f50733          	add	a4,a0,a5
    8000519c:	00b70023          	sb	a1,0(a4)
    800051a0:	0017871b          	addiw	a4,a5,1
    800051a4:	0cc77663          	bgeu	a4,a2,80005270 <__memset+0x1c8>
    800051a8:	00e50733          	add	a4,a0,a4
    800051ac:	00b70023          	sb	a1,0(a4)
    800051b0:	0027871b          	addiw	a4,a5,2
    800051b4:	0ac77e63          	bgeu	a4,a2,80005270 <__memset+0x1c8>
    800051b8:	00e50733          	add	a4,a0,a4
    800051bc:	00b70023          	sb	a1,0(a4)
    800051c0:	0037871b          	addiw	a4,a5,3
    800051c4:	0ac77663          	bgeu	a4,a2,80005270 <__memset+0x1c8>
    800051c8:	00e50733          	add	a4,a0,a4
    800051cc:	00b70023          	sb	a1,0(a4)
    800051d0:	0047871b          	addiw	a4,a5,4
    800051d4:	08c77e63          	bgeu	a4,a2,80005270 <__memset+0x1c8>
    800051d8:	00e50733          	add	a4,a0,a4
    800051dc:	00b70023          	sb	a1,0(a4)
    800051e0:	0057871b          	addiw	a4,a5,5
    800051e4:	08c77663          	bgeu	a4,a2,80005270 <__memset+0x1c8>
    800051e8:	00e50733          	add	a4,a0,a4
    800051ec:	00b70023          	sb	a1,0(a4)
    800051f0:	0067871b          	addiw	a4,a5,6
    800051f4:	06c77e63          	bgeu	a4,a2,80005270 <__memset+0x1c8>
    800051f8:	00e50733          	add	a4,a0,a4
    800051fc:	00b70023          	sb	a1,0(a4)
    80005200:	0077871b          	addiw	a4,a5,7
    80005204:	06c77663          	bgeu	a4,a2,80005270 <__memset+0x1c8>
    80005208:	00e50733          	add	a4,a0,a4
    8000520c:	00b70023          	sb	a1,0(a4)
    80005210:	0087871b          	addiw	a4,a5,8
    80005214:	04c77e63          	bgeu	a4,a2,80005270 <__memset+0x1c8>
    80005218:	00e50733          	add	a4,a0,a4
    8000521c:	00b70023          	sb	a1,0(a4)
    80005220:	0097871b          	addiw	a4,a5,9
    80005224:	04c77663          	bgeu	a4,a2,80005270 <__memset+0x1c8>
    80005228:	00e50733          	add	a4,a0,a4
    8000522c:	00b70023          	sb	a1,0(a4)
    80005230:	00a7871b          	addiw	a4,a5,10
    80005234:	02c77e63          	bgeu	a4,a2,80005270 <__memset+0x1c8>
    80005238:	00e50733          	add	a4,a0,a4
    8000523c:	00b70023          	sb	a1,0(a4)
    80005240:	00b7871b          	addiw	a4,a5,11
    80005244:	02c77663          	bgeu	a4,a2,80005270 <__memset+0x1c8>
    80005248:	00e50733          	add	a4,a0,a4
    8000524c:	00b70023          	sb	a1,0(a4)
    80005250:	00c7871b          	addiw	a4,a5,12
    80005254:	00c77e63          	bgeu	a4,a2,80005270 <__memset+0x1c8>
    80005258:	00e50733          	add	a4,a0,a4
    8000525c:	00b70023          	sb	a1,0(a4)
    80005260:	00d7879b          	addiw	a5,a5,13
    80005264:	00c7f663          	bgeu	a5,a2,80005270 <__memset+0x1c8>
    80005268:	00f507b3          	add	a5,a0,a5
    8000526c:	00b78023          	sb	a1,0(a5)
    80005270:	00813403          	ld	s0,8(sp)
    80005274:	01010113          	addi	sp,sp,16
    80005278:	00008067          	ret
    8000527c:	00b00693          	li	a3,11
    80005280:	e55ff06f          	j	800050d4 <__memset+0x2c>
    80005284:	00300e93          	li	t4,3
    80005288:	ea5ff06f          	j	8000512c <__memset+0x84>
    8000528c:	00100e93          	li	t4,1
    80005290:	e9dff06f          	j	8000512c <__memset+0x84>
    80005294:	00000e93          	li	t4,0
    80005298:	e95ff06f          	j	8000512c <__memset+0x84>
    8000529c:	00000793          	li	a5,0
    800052a0:	ef9ff06f          	j	80005198 <__memset+0xf0>
    800052a4:	00200e93          	li	t4,2
    800052a8:	e85ff06f          	j	8000512c <__memset+0x84>
    800052ac:	00400e93          	li	t4,4
    800052b0:	e7dff06f          	j	8000512c <__memset+0x84>
    800052b4:	00500e93          	li	t4,5
    800052b8:	e75ff06f          	j	8000512c <__memset+0x84>
    800052bc:	00600e93          	li	t4,6
    800052c0:	e6dff06f          	j	8000512c <__memset+0x84>

00000000800052c4 <__memmove>:
    800052c4:	ff010113          	addi	sp,sp,-16
    800052c8:	00813423          	sd	s0,8(sp)
    800052cc:	01010413          	addi	s0,sp,16
    800052d0:	0e060863          	beqz	a2,800053c0 <__memmove+0xfc>
    800052d4:	fff6069b          	addiw	a3,a2,-1
    800052d8:	0006881b          	sext.w	a6,a3
    800052dc:	0ea5e863          	bltu	a1,a0,800053cc <__memmove+0x108>
    800052e0:	00758713          	addi	a4,a1,7
    800052e4:	00a5e7b3          	or	a5,a1,a0
    800052e8:	40a70733          	sub	a4,a4,a0
    800052ec:	0077f793          	andi	a5,a5,7
    800052f0:	00f73713          	sltiu	a4,a4,15
    800052f4:	00174713          	xori	a4,a4,1
    800052f8:	0017b793          	seqz	a5,a5
    800052fc:	00e7f7b3          	and	a5,a5,a4
    80005300:	10078863          	beqz	a5,80005410 <__memmove+0x14c>
    80005304:	00900793          	li	a5,9
    80005308:	1107f463          	bgeu	a5,a6,80005410 <__memmove+0x14c>
    8000530c:	0036581b          	srliw	a6,a2,0x3
    80005310:	fff8081b          	addiw	a6,a6,-1
    80005314:	02081813          	slli	a6,a6,0x20
    80005318:	01d85893          	srli	a7,a6,0x1d
    8000531c:	00858813          	addi	a6,a1,8
    80005320:	00058793          	mv	a5,a1
    80005324:	00050713          	mv	a4,a0
    80005328:	01088833          	add	a6,a7,a6
    8000532c:	0007b883          	ld	a7,0(a5)
    80005330:	00878793          	addi	a5,a5,8
    80005334:	00870713          	addi	a4,a4,8
    80005338:	ff173c23          	sd	a7,-8(a4)
    8000533c:	ff0798e3          	bne	a5,a6,8000532c <__memmove+0x68>
    80005340:	ff867713          	andi	a4,a2,-8
    80005344:	02071793          	slli	a5,a4,0x20
    80005348:	0207d793          	srli	a5,a5,0x20
    8000534c:	00f585b3          	add	a1,a1,a5
    80005350:	40e686bb          	subw	a3,a3,a4
    80005354:	00f507b3          	add	a5,a0,a5
    80005358:	06e60463          	beq	a2,a4,800053c0 <__memmove+0xfc>
    8000535c:	0005c703          	lbu	a4,0(a1)
    80005360:	00e78023          	sb	a4,0(a5)
    80005364:	04068e63          	beqz	a3,800053c0 <__memmove+0xfc>
    80005368:	0015c603          	lbu	a2,1(a1)
    8000536c:	00100713          	li	a4,1
    80005370:	00c780a3          	sb	a2,1(a5)
    80005374:	04e68663          	beq	a3,a4,800053c0 <__memmove+0xfc>
    80005378:	0025c603          	lbu	a2,2(a1)
    8000537c:	00200713          	li	a4,2
    80005380:	00c78123          	sb	a2,2(a5)
    80005384:	02e68e63          	beq	a3,a4,800053c0 <__memmove+0xfc>
    80005388:	0035c603          	lbu	a2,3(a1)
    8000538c:	00300713          	li	a4,3
    80005390:	00c781a3          	sb	a2,3(a5)
    80005394:	02e68663          	beq	a3,a4,800053c0 <__memmove+0xfc>
    80005398:	0045c603          	lbu	a2,4(a1)
    8000539c:	00400713          	li	a4,4
    800053a0:	00c78223          	sb	a2,4(a5)
    800053a4:	00e68e63          	beq	a3,a4,800053c0 <__memmove+0xfc>
    800053a8:	0055c603          	lbu	a2,5(a1)
    800053ac:	00500713          	li	a4,5
    800053b0:	00c782a3          	sb	a2,5(a5)
    800053b4:	00e68663          	beq	a3,a4,800053c0 <__memmove+0xfc>
    800053b8:	0065c703          	lbu	a4,6(a1)
    800053bc:	00e78323          	sb	a4,6(a5)
    800053c0:	00813403          	ld	s0,8(sp)
    800053c4:	01010113          	addi	sp,sp,16
    800053c8:	00008067          	ret
    800053cc:	02061713          	slli	a4,a2,0x20
    800053d0:	02075713          	srli	a4,a4,0x20
    800053d4:	00e587b3          	add	a5,a1,a4
    800053d8:	f0f574e3          	bgeu	a0,a5,800052e0 <__memmove+0x1c>
    800053dc:	02069613          	slli	a2,a3,0x20
    800053e0:	02065613          	srli	a2,a2,0x20
    800053e4:	fff64613          	not	a2,a2
    800053e8:	00e50733          	add	a4,a0,a4
    800053ec:	00c78633          	add	a2,a5,a2
    800053f0:	fff7c683          	lbu	a3,-1(a5)
    800053f4:	fff78793          	addi	a5,a5,-1
    800053f8:	fff70713          	addi	a4,a4,-1
    800053fc:	00d70023          	sb	a3,0(a4)
    80005400:	fec798e3          	bne	a5,a2,800053f0 <__memmove+0x12c>
    80005404:	00813403          	ld	s0,8(sp)
    80005408:	01010113          	addi	sp,sp,16
    8000540c:	00008067          	ret
    80005410:	02069713          	slli	a4,a3,0x20
    80005414:	02075713          	srli	a4,a4,0x20
    80005418:	00170713          	addi	a4,a4,1
    8000541c:	00e50733          	add	a4,a0,a4
    80005420:	00050793          	mv	a5,a0
    80005424:	0005c683          	lbu	a3,0(a1)
    80005428:	00178793          	addi	a5,a5,1
    8000542c:	00158593          	addi	a1,a1,1
    80005430:	fed78fa3          	sb	a3,-1(a5)
    80005434:	fee798e3          	bne	a5,a4,80005424 <__memmove+0x160>
    80005438:	f89ff06f          	j	800053c0 <__memmove+0xfc>
	...
