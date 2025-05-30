import { isAxiosError } from "axios"
import api from "../lib/axios"
import { PropertyTax } from "../types"

/**
 * Obtiene todos los PropertyTax de una land
 */
/*
export async function getPropertyTaxesByLandId(landId: number): Promise<PropertyTax[]> {
  try {
    const { data } = await api<PropertyTax[]>(`/land/${landId}/property-taxes`)
    return data
  } catch (error) {
    if (isAxiosError(error) && error.response) {
      const msg = (error.response.data as any).detail ?? 'Error fetching property taxes'
      throw new Error(msg)
    }
    throw new Error('Unexpected error fetching property taxes')
  }
}
*/

/**
 * Obtiene un PropertyTax por su ID
 */
export async function getPropertyTaxById(id: number): Promise<PropertyTax> {
  try {
    //const { data } = await api<PropertyTax>(`/property-tax/${id}`)
    const { data } = await api.get<PropertyTax>(`/property-tax/getPropertyTaxById/${id}`);
    return data
  } catch (error) {
    if (isAxiosError(error) && error.response) {
      const msg = (error.response.data as any).detail ?? 'Error fetching property tax'
      throw new Error(msg)
    }
    throw new Error('Unexpected error fetching property tax')
  }
}

/**
 * Crea un nuevo PropertyTax
 */
export async function createPropertyTax(payload: Partial<PropertyTax>): Promise<PropertyTax> {
  try {
    const { data } = await api.post<PropertyTax>('/property-tax/', payload)
    return data
  } catch (error) {
    if (isAxiosError(error) && error.response) {
      const detail = error.response.data?.detail;

      if (Array.isArray(detail)) {
        // Ejemplo: loc = ["body", "property_tax_estatus_id"], msg = "Field required"
        const messages = detail.map((d: any) => {
          const field = d.loc?.[1] ?? 'Campo desconocido';
          const message = d.msg ?? 'Error';
          return `${field}: ${message}`;
        }).join('; ');
        
        throw new Error(messages);
      }

      if (typeof detail === 'string') {
        throw new Error(detail);
      }

      throw new Error('Error creando predial');
    }

    throw new Error('Error inesperado al crear predial');
  }
}


/**
 * Actualiza un PropertyTax existente
 */
export async function updatePropertyTax(id: number, payload: Partial<PropertyTax>): Promise<PropertyTax> {
  try {
    const { data } = await api.put<PropertyTax>(`/property-tax/`,payload);
    return data
  } catch (error) {
    if (isAxiosError(error) && error.response) {
      const detail = error.response.data?.detail;

      if (Array.isArray(detail)) {
        // Ejemplo: loc = ["body", "property_tax_estatus_id"], msg = "Field required"
        const messages = detail.map((d: any) => {
          const field = d.loc?.[1] ?? 'Campo desconocido';
          const message = d.msg ?? 'Error';
          return `${field}: ${message}`;
        }).join('; ');
        
        throw new Error(messages);
      }

      if (typeof detail === 'string') {
        throw new Error(detail);
      }

      throw new Error('Error creando impuesto');
    }
    throw new Error('Unexpected error updating property tax')
  }
}
