/*
 * gyro.c
 *
 *  Created on: 7. feb. 2023
 *      Author: Jakob
 */

#include "gyro.h"

void gyro_init() {
	L3GD20_InitTypeDef init = { L3GD20_MODE_ACTIVE, L3GD20_ODR_1, L3GD20_XYZ_ENABLE, L3GD20_BW_4, L3GD20_BDU_CONTINUOS, L3GD20_BLE_LITTLE, L3GD20_FS_500 };
	l3gd20_init(&init);
}
