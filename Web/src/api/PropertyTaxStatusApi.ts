import { isAxiosError } from 'axios'
import api from '../lib/axios'
import type { PropertyTaxStatus } from '../types'

// Obtener todos los estatus de impuesto predial
export async function getPropertyTaxStatuses(): Promise<PropertyTaxStatus[]> {
  try {
    const { data } = await api.get<PropertyTaxStatus[]>('/property-tax-status')
    return data
  } catch (error) {
    if (isAxiosError(error) && error.response) {
      throw new Error((error.response.data as any).detail || error.message)
    }
    throw error
  }
}

// Obtener un estatus de impuesto predial por ID
export async function getPropertyTaxStatusById(id: number): Promise<PropertyTaxStatus> {
  try {
    const { data } = await api.get<PropertyTaxStatus>(`/property-tax-status/${id}`)
    return data
  } catch (error) {
    if (isAxiosError(error) && error.response) {
      throw new Error((error.response.data as any).detail || error.message)
    }
    throw error
  }
}

// Crear nuevo estatus de impuesto predial
export async function createPropertyTaxStatus(
  status: Omit<PropertyTaxStatus, 'id'>
): Promise<PropertyTaxStatus> {
  try {
    const { data } = await api.post<PropertyTaxStatus>('/property-tax-status', status)
    return data
  } catch (error) {
    if (isAxiosError(error) && error.response) {
      throw new Error((error.response.data as any).detail || error.message)
    }
    throw error
  }
}

// Actualizar estatus de impuesto predial existente
export async function updatePropertyTaxStatus(
  status: PropertyTaxStatus
): Promise<PropertyTaxStatus> {
  try {
    const { data } = await api.put<PropertyTaxStatus>(
      `/property-tax-status/${status.id}`,
      status
    )
    return data
  } catch (error) {
    if (isAxiosError(error) && error.response) {
      throw new Error((error.response.data as any).detail || error.message)
    }
    throw error
  }
}

// Eliminar estatus de impuesto predial por ID
export async function deletePropertyTaxStatus(id: number): Promise<void> {
  try {
    await api.delete(`/property-tax-status/${id}`)
  } catch (error) {
    if (isAxiosError(error) && error.response) {
      throw new Error((error.response.data as any).detail || error.message)
    }
    throw error
  }
}
